import 'dart:async';
import 'dart:typed_data';

import 'package:buyoil/common/app_commands.dart';
import 'package:buyoil/common/utils/show_toast.dart';
import 'package:buyoil/common/utils/toast/toast_provider.dart';
import 'package:buyoil/model/ui_state_usb_port.dart';
import 'package:buyoil/router.dart';
import 'package:buyoil/viewmodel/vm_sendPostPer.dart';
import 'package:buyoil/viewmodel/vm_sendData.dart';
import 'package:buyoil/viewmodel/vm_step1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io'; // Platform 확인용
import 'package:flutter_libserialport/flutter_libserialport.dart'; // Windows용
import 'package:usb_serial/usb_serial.dart'; // 기존 Android용

import '../common/app_strings.dart';
import '../config.dart';

part 'vm_serial_port.g.dart';

@Riverpod(keepAlive: true)
class SerialPortVM extends _$SerialPortVM {
  dynamic _subscription;
  SerialPortReader?
  _reader; // <--- [추가] Windows용 리더 객체를 멤버 변수로 유지해야 GC에 의해 끊기지 않습니다.

  final StringBuffer _receiveBuffer = StringBuffer();
  static const String _terminator = '#';

  final RegExp formatRegex = RegExp(
    r'^(?:\[ANS\])?O\d+(\.\d+)?W\d+(\.\d+)?E#?$',
  );
  int _connectionAttemptIndex = 0;
  Timer? _inactivityTimer; // <--- 1. 비활성 상태 감지를 위한 타이머 추가

  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 10; // 최대 10번까지만 시도
  Timer? _reconnectTimer;

  @override
  UIStateUsbPort build() {
    print("SerialPortVM: build();");
    _reconnectAttempts = 0;

    ref.onDispose(() {
      _subscription?.cancel();
      _reader?.close(); // <--- [추가] 리더 종료
      try {
        state.port?.close();
      } catch (e) {}
      _inactivityTimer?.cancel();
      _reconnectTimer?.cancel();
      print("SerialPortVM disposed.");
    });

    _init();
    _resetInactivityTimer();
    return UIStateUsbPort.init(availablePorts: []);
  }

  // <--- 2. 타이머를 시작하고 재설정하는 헬퍼 메서드 추가 ---
  void _resetInactivityTimer() {
    _inactivityTimer?.cancel(); // 기존 타이머가 있다면 취소
    _inactivityTimer = Timer.periodic(
      const Duration(seconds: kDebugMode ? 120 : 120),
      (timer) {
        // 120초 동안 아무런 쓰기 작업이 없으면 SLEEP 명령어 전송
        // showScafold(AppStrings.trySleep);
        writeToPort(PORT_COMMANDS.sleep);
      },
    );
  }

  _init() async {
    connectPort();
  }

  Future<void> connectPort({BuildContext? context}) async {
    // 1. 기존 연결 및 구독 자원의 완전한 정리
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _reader?.close();
    _reader = null;

    // 기존 포트가 있다면 닫고 네이티브 메모리 해제(dispose)
    if (state.port != null) {
      try {
        // libserialport에서는 close 후 dispose를 호출해야 핸들이 완전히 풀립니다.
        state.port!.close();
        state.port!.dispose();
      } catch (e) {
        print("Error disposing previous port: $e");
      }
    }

    _receiveBuffer.clear();

    // 재연결 시도가 아닌 첫 연결일 경우 상태 초기화
    if (_reconnectAttempts == 0) {
      state = UIStateUsbPort.init();
    }

    // Windows 섹션 내부 수정
    if (Platform.isWindows) {
      final List<String> portNames = SerialPort.availablePorts;
      if (portNames.isEmpty) {
        state = UIStateUsbPort.error(
          errorMsg: AppStrings.noConnectableDevicesFound,
        );
        return;
      }

      // 이전에 열려있던 포트와 이름이 같다면 OS가 해제할 시간을 더 줘야 합니다.
      String selectedPortName = "COM15"; // 혹은 portNames.first;

      // [추가] 물리적인 아주 짧은 대기 (OS 핸들 해제 시간 벌기)
      await Future.delayed(const Duration(milliseconds: 200));

      final port = SerialPort(selectedPortName);
      print("Attempting to open $selectedPortName (Pointer: ${port.address})");

      try {
        // openReadWrite가 실패하면 open(mode: SerialPortMode.readWrite)로 시도
        bool openSuccess = port.openReadWrite();

        if (!openSuccess) {
          print(
            "Failed to open port $selectedPortName - OS is still locking the port.",
          );
          port.dispose();
          _handleDisconnection(); // 여기서 다시 5초 대기 후 시도하게 됨
          return;
        }

        // SerialPortVM.dart 내 connectPort 함수 내부
        final config = SerialPortConfig()
          ..baudRate = 115200
          ..bits = 8
          ..stopBits = 1
          ..parity = SerialPortParity.none
          ..setFlowControl(SerialPortFlowControl.none); // 하드웨어 흐름제어 비활성화

        port.config = config;

        port.config = config;

        state = UIStateUsbPort.connected(port: port, connectedDevice: null);

        // Reader 생성 및 구독
        _reader = SerialPortReader(port);
        _subscription = _reader!.stream.listen(
          (Uint8List data) {
            // 데이터가 들어오면 연결이 유효한 것으로 간주하여 카운트 초기화
            if (_reconnectAttempts > 0) {
              _reconnectAttempts = 0;
              _reconnectTimer?.cancel();
            }
            _receiveBuffer.write(String.fromCharCodes(data));
            _processBuffer();
          },
          onError: (error) {
            print("Windows Stream Error: $error");
            _handleDisconnection();
          },
          onDone: () {
            print("Windows Stream Done (Device disconnected)");
            _handleDisconnection();
          },
        );

        _resetInactivityTimer();
        print("Windows Port Connected Successfully: $selectedPortName");
      } catch (e) {
        print("Windows Connection Exception: $e");
        _handleDisconnection();
      }
    } else {
      // ############ Android용 로직 (기존 유지) ############
      List<UsbDevice> devices = await UsbSerial.listDevices();
      if (devices.isEmpty) {
        state = UIStateUsbPort.error(
          errorMsg: AppStrings.noConnectableDevicesFound,
        );
        return;
      }

      UsbDevice deviceToConnect = devices.first;
      UsbPort? port = await deviceToConnect.create();

      if (port == null || !(await port.open())) {
        state = UIStateUsbPort.error(errorMsg: AppStrings.cannotOpenPort);
        _handleDisconnection();
        return;
      }

      await port.setPortParameters(
        115200,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      _subscription = port.inputStream!.listen(
        (Uint8List data) {
          _reconnectAttempts = 0;
          _receiveBuffer.write(String.fromCharCodes(data));
          _processBuffer();
        },
        onDone: () => _handleDisconnection(),
        onError: (e) => _handleDisconnection(),
      );

      state = UIStateUsbPort.connected(
        port: port,
        connectedDevice: deviceToConnect,
      );
      _resetInactivityTimer();
    }
  }

  void _handleDisconnection() {
    _subscription?.cancel();
    _subscription = null;
    _reader?.close(); // <--- [추가] 리더 안전 종료
    _reader = null;

    try {
      state.port?.close();
    } catch (e) {
      print("Error closing port during disconnection: $e");
    }

    _attemptReconnect();
  }

  void _attemptReconnect() {
    if (_reconnectTimer?.isActive ?? false) return;

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      state = UIStateUsbPort.error(errorMsg: "연결 실패. 케이블을 확인하세요.");
      return;
    }

    _reconnectAttempts++;

    // 3초에서 5초 정도로 늘려 OS의 포트 점유 해제 대기
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connectPort();
    });
  }

  /// 포트에 쓰기
  Future<void> writeToPort(
    PORT_COMMANDS command, {
    BuildContext? context,
  }) async {
    if (command != PORT_COMMANDS.sleep) {
      _resetInactivityTimer();
    }

    if (Config.instance.isDebugMode) {
      state = state.copyWith(lastCommand: command);
      String packet = "${command.command}";
      final dataToSend = Uint8List.fromList(packet.codeUnits);
      write(dataToSend);
      return;
    }

    if (state is UIStateUsbPortConnected) {
      state = state.copyWith(lastCommand: command);
      String packet = "${command.command}";
      final dataToSend = Uint8List.fromList(packet.codeUnits);
      write(dataToSend);
    } else {
      if (context != null && context.mounted) {
        showToastMessage(context, "Port not connected");
      }
    }
  }

  Future<void> writeToPortPhone(
    String phoneCommand, {
    BuildContext? context,
  }) async {
    _resetInactivityTimer();

    // 전화번호 정리
    String cleanNumber = phoneCommand;
    if (cleanNumber.startsWith('[VALID]')) {
      cleanNumber = cleanNumber.replaceFirst('[VALID]', '');
    }
    if (cleanNumber.endsWith('ENDSTR')) {
      cleanNumber = cleanNumber.replaceFirst('ENDSTR', '');
    }

    print('[PHONE] raw=$phoneCommand / clean=$cleanNumber');

    UserResult? fetchResult = await fetchUser(cleanNumber);

    if (fetchResult != null) {
      state = state.copyWith(lastCommand: PORT_COMMANDS.cmdPhone);
      listenByPort(PORT_RESPONSES.ok.response);
      print('[Phone] userId=${fetchResult.userId}');
      print('[Phone] driver=${fetchResult.driver}');
      print("fetchResult 검증 ...");
      print("STATE 검증 : ${state}");
      print("STATE 검증 : ${state}");
      String packet = "$phoneCommand#";
      final dataToSend = Uint8List.fromList(packet.codeUnits);
      write(dataToSend);
    } else {
      print('[PHONE] Fetch fail');
      if (context != null && context.mounted) {
        showToastMessage(context, "인증 실패");
      }
      return;
    }
  }

  Future<void> writeToPortRFID(
    String rfidCommand, {
    BuildContext? context,
  }) async {
    _resetInactivityTimer();

    String cleanNumber = rfidCommand;
    if (cleanNumber.startsWith('[VALID]')) {
      cleanNumber = cleanNumber.replaceFirst('[VALID]', '');
    }
    if (cleanNumber.endsWith('ENDSTR')) {
      cleanNumber = cleanNumber.replaceFirst('ENDSTR', '');
    }

    print('[RFID] raw=$rfidCommand / clean=$cleanNumber');

    UserResult? fetchResult = await fetchUser(cleanNumber);

    if (fetchResult != null) {
      state = state.copyWith(lastCommand: PORT_COMMANDS.cmdRFID);
      listenByPort(PORT_RESPONSES.ok.response);
      print('[RFID] userId=${fetchResult.userId}');
      print('[RFID] driver=${fetchResult.driver}');
      print("STATE 검증 : ${state}");
      print("STATE 검증 : ${state}");
      print("fetchResult 검증 ...");
      String packet = "$rfidCommand#";
      final dataToSend = Uint8List.fromList(packet.codeUnits);
      write(dataToSend);
    } else {
      print('[RFID] Fetch fail');
      if (context != null && context.mounted) {
        showToastMessage(context, "인증 실패");
      }
      return; // 여기서 종료
    }
  }

  Future<void> writeToPortPostUCO(
    String ucoJson, {
    BuildContext? context,
  }) async {
    _resetInactivityTimer();

    final fetchResult = await fetchPostUCO(ucoJson);

    if (fetchResult != null) {
      state = state.copyWith(lastCommand: PORT_COMMANDS.postper);
      listenByPort(PORT_RESPONSES.ok.response);
    }
  }

  Future<void> writeToPortPostPer(
    String measuredData, {
    BuildContext? context,
  }) async {
    _resetInactivityTimer();

    print("[POST_PER][RAW] $measuredData");

    final fetchResult = await fetchPostPer(measuredData);

    if (fetchResult != null) {
      state = state.copyWith(lastCommand: PORT_COMMANDS.postper);
      listenByPort(PORT_RESPONSES.ok.response);
    }
  }

  // 포트에서 받은 값 처리
  // 직전 명령에 따라서 동작 별도 처리
  void listenByPort(String receivedString) {
    if (!receivedString.startsWith(AppCommands.prefixAnswer)) {
      // showScafold("Prefix String is not [ANS]");
      return;
    }

    // 1. ACK 메시지는 로직에 영향을 주지 않도록 즉시 리턴
    if (receivedString == "[ANS]ACK") {
      print("Ignore ACK message from STM32");
      return;
    }

    print("[DEBUG] lastCommand  : ${state.lastCommand}");
    print("[DEBUG] listenByPort : $receivedString");
    // 최초 화면에서
    if (state.lastCommand == PORT_COMMANDS.handshake) {
      // OK 받으면
      if (receivedString == PORT_RESPONSES.ok.response) {
        // 전화번호 입력 페이지 이동
        ref.watch(routerProvider).goNamed(RouteGroup.Step1.name);
      } else if (receivedString == PORT_RESPONSES.fail.response) {
        // 아니면 기본 화면 유지
        ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      } else if (receivedString == PORT_RESPONSES.full.response) {
        ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
        // 1. 5초간 팝업 띄우기
        ref
            .read(toastProvider.notifier)
            .showToast(
              AppStrings.fullContainer,
              duration: Duration(seconds: 5),
            );
      }
    }

    if (receivedString == PORT_RESPONSES.fail.response) {
      print("STM32 returned FAIL - logic rejected, but keep connection alive.");
      return;
    }

    // if (receivedString == PORT_RESPONSES.fail.response) {
    //   state = state.copyWith(lastCommand: null);
    //   // 2. 첫 페이지(Splash)로 이동
    //   ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
    //   // 1. 5초간 팝업 띄우기
    //   ref
    //       .read(toastProvider.notifier)
    //       .showToast(AppStrings.systemError, duration: Duration(seconds: 5));
    //   return;
    // }

    // [ANS]STM_SLEEP# 응답을 받으면
    if (receivedString == PORT_RESPONSES.stmSleep.response) {
      // showScafold("Received STM_SLEEP. Going to Splash.");
      // 스플래시 화면으로 이동
      ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      // lastCommand를 초기화하여 추가 동작 방지
      state = state.copyWith(lastCommand: null);
      return; // 이 응답 처리는 여기서 종료
    }

    // 전화번호 send 응답이
    if (state.lastCommand == PORT_COMMANDS.cmdPhone ||
        state.lastCommand == PORT_COMMANDS.cmdRFID) {
      // OK 받으면
      if (receivedString == PORT_RESPONSES.ok.response) {
        // 성공 시 실패 카운터 초기화
        state = state.copyWith(resetFailCount: 0);

        // page4(Step2) 오픈 화면 이동
        ref.watch(routerProvider).goNamed(RouteGroup.Step2.name);
      } else if (receivedString == PORT_RESPONSES.open.response) {
        // 성공 시 실패 카운터 초기화
        state = state.copyWith(resetFailCount: 0);
        // Opening Door Screen 이동
        ref.watch(routerProvider).goNamed(RouteGroup.OpeningDoor.name);
      } else if (receivedString == PORT_RESPONSES.fail.response) {
        // todo 변경사항 확인하기
        ref.read(step1Provider.notifier).showErrorToast();
      } else if (receivedString == PORT_RESPONSES.reject.response) {
        final newFailCount = (state.resetFailCount ?? 0) + 1;
        state = state.copyWith(resetFailCount: newFailCount);
        if (newFailCount >= 5) {
          // 1. 5회 실패: 첫 페이지로 복귀
          ref
              .read(toastProvider.notifier)
              .showToast(
                AppStrings.accessDenied,
                duration: Duration(seconds: 5),
              );
          ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
          // 상태 초기화
          state = state.copyWith(lastCommand: null, resetFailCount: 0);
        } else {
          // 2. 5회 미만 실패: 팝업 메시지 표시 (페이지는 그대로 유지)
          ref
              .read(toastProvider.notifier)
              .showToast(
                AppStrings.accessDenied,
                duration: Duration(seconds: 3),
              );
        }
        // todo 변경사항 확인하기
      } else if (receivedString == PORT_RESPONSES.notAuth.response) {
        // *return “NOTAUTH” -> Please shows the proper driver code
        // TODO
      } else if (receivedString == PORT_RESPONSES.driverTrue.response) {
        // send "[CMD]OPENB#" and shows driver's page.
        writeToPort(PORT_COMMANDS.openB).whenComplete(() {
          goToDriverPage();
        });
      } else if (receivedString == PORT_RESPONSES.driverFalse.response) {
        ref.read(toastProvider.notifier).showToast(AppStrings.notAuthorized);
        // send "[CMD]SLEEP#" and shows not authorized.
        writeToPort(PORT_COMMANDS.sleep);
      }
    }

    // Open 명령어
    if (state.lastCommand == PORT_COMMANDS.open) {
      // ok 응답 -> Close 화면 이동
      if (receivedString == PORT_RESPONSES.ok.response) {
        ref.watch(routerProvider).goNamed(RouteGroup.Step3.name);
      }
    }

    // 'postper'
    if (state.lastCommand == PORT_COMMANDS.postper) {
      if (receivedString == PORT_RESPONSES.ok.response) {
        // 1. postper에 대한 응답을 받으면 lastCommand를 초기화하여 재시도 타이머를 멈춤
        state = state.copyWith(lastCommand: null);
        // 1-1. 응답이 'OK'이면, 바로 'postData'를 전송
        print("Received OK for 'postper', now sending 'postData'.");
        // showScafold("Received OK for 'postper', now sending 'postData'.");
        // poster -> postData 로 이어지므로 마지막 명령어 자체 업데이트
        state = state.copyWith(lastCommand: PORT_COMMANDS.postData);
        okayNextStep(); // postData를 보내는 전용 함수 호출
        return;
      }
    }

    if (state.lastCommand == PORT_COMMANDS.postData) {
      if (receivedString == PORT_RESPONSES.ok.response) {
        // 2. postData에 대한 응답을 받으면 lastCommand를 초기화하여 재시도 타이머를 멈춤
        state = state.copyWith(lastCommand: null);
        // 2-1. 응답이 'OK'이면 모든 과정이 성공했으므로 스플래시 화면으로 이동
        print("Received OK for 'postData'. Process complete.");
        // showScafold("Received OK for 'postData'. Process complete.");
        ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      }
    }

    // Close 명령어
    if (state.lastCommand == PORT_COMMANDS.close) {
      if (formatRegex.hasMatch(receivedString)) {
        state = state.copyWith(lastCommand: null);

        (double oil, double water) res = AppCommands.returnOilWaterFormat(receivedString);

        if (state.connectedDevice != null && state.port != null) {
          state = UIStateUsbPort.connected(
            availablePorts: state.availablePorts,
            connectedDevice: state.connectedDevice!,
            port: state.port!,
            lastCommand: null, // 확실히 비워줌
          );
        }

        ref.read(routerProvider).goNamed(
          RouteGroup.Step4.name,
          queryParameters: {"oil": "${res.$1}", "water": "${res.$2}"},
        );

        return; // 처리가 완료되었으므로 함수 종료
      }
    }

    if (state.lastCommand == PORT_COMMANDS.recheck) {
      // O, W, E 포맷이면
      if (formatRegex.hasMatch(receivedString)) {
        // 초기화 후 Step4화면 재실행
        state = UIStateUsbPortConnected(
          availablePorts: state.availablePorts,
          connectedDevice: state.connectedDevice,
          port: state.port,
          lastCommand: null,
        );

        (double oil, double water) res = AppCommands.returnOilWaterFormat(
          receivedString,
        );
        // 초기화 후 Step4화면 재실행
        print("recheck success: ${state.connectedDevice}/ ${state.port}");
        ref
            .read(routerProvider)
            .goNamed(
              RouteGroup.Step4.name,
              queryParameters: {"oil": "${res.$1}", "water": "${res.$2}"},
            );
      }
    }

    // ok 명령 받은 경우 lastCommand 초기화
    if (receivedString == PORT_RESPONSES.ok.response) {
      if (state.lastCommand == PORT_COMMANDS.postData ||
          state.lastCommand == PORT_COMMANDS.postper ||
          state.lastCommand == PORT_COMMANDS.recheck) {
        return;
      }
      state = state.copyWith(lastCommand: null);
    }
  }

  // 스플래시 화면 이동 및 close 명령
  Future<void> goToSplash() async {
    return await writeToPort(PORT_COMMANDS.close);
  }

  // 드라이버 페이지로 이동
  void goToDriverPage() {
    ref.read(routerProvider).goNamed(RouteGroup.Driver.name);
  }

  // open
  Future<void> open() async {
    // 이미 실행 중이면 중복 실행 방지
    if (state.lastCommand == PORT_COMMANDS.open) return;

    // STM32의 OPEN_INPUT 작업(10~20초)을 고려하여 타임아웃을 대폭 늘림
    Future.delayed(const Duration(seconds: 40), () {
      if (state.lastCommand == PORT_COMMANDS.open) {
        writeToPort(PORT_COMMANDS.open);
      }
    });

    return writeToPort(PORT_COMMANDS.open);
  }

  Future<void> close() async {
    // 30초 이내에 ok 안오면 재시도
    Future.delayed(Duration(seconds: Config.instance.isDebugMode ? 5 : 30), () {
      if (state.lastCommand == PORT_COMMANDS.close) {
        close();
      }
    });

    return writeToPort(PORT_COMMANDS.close);
  }

  Future<void> start() async {
    return await writeToPort(PORT_COMMANDS.handshake);
  }

  Future<void> okay({double? oil, double? water}) async {
    if (oil != null && water != null) {
      final String ucoJson = '{"oil": $oil, "water": $water}';
      writeToPortPostUCO(ucoJson);
    }

    // 3. 재시도 로직 (단 하나만 유지)
    Future.delayed(Duration(seconds: Config.instance.isDebugMode ? 5 : 10), () {
      // 여전히 응답을 기다리는 상태(postper 혹은 postData)라면 재시도
      if (state.lastCommand == PORT_COMMANDS.postper ||
          state.lastCommand == PORT_COMMANDS.postData) {
        print("장치 응답 없음 -> 재시도 실행 (값 보존: $oil, $water)");
        okay(oil: oil, water: water);
      }
    });

    // 4. 장치(STM32)에 명령어 전송
    print('장치에 [CMD]POSTPER# 전송');
    await writeToPort(PORT_COMMANDS.postper);

    // 5. 로딩 상태로 변경
    state = UIStateUsbPort.loading(
      availablePorts: state.availablePorts,
      connectedDevice: state.connectedDevice,
      port: state.port,
      lastCommand: state.lastCommand,
    );
  }

  /// 'okay' 프로세스의 두 번째 단계: 'postData' 전송 및 재시도 설정
  Future<void> okayNextStep() async {
    // 1. 'postData' 명령에 대한 타임아웃/재시도 로직 설정
    Future.delayed(Duration(seconds: Config.instance.isDebugMode ? 5 : 10), () {
      if (state.lastCommand == PORT_COMMANDS.postData) {
        // showScafold("No response for 'postData', retrying...");
        print("No response for 'postData', retrying...");
        okayNextStep(); // 'postData' 전송 재시도
      }
    });

    // 2. 'postData' 명령어 전송
    await writeToPort(PORT_COMMANDS.postData);
  }

  Future<void> recheck() async {
    // 1. 상태를 로딩으로 변경하여 UI에 스피너(Spinner) 표시
    state = UIStateUsbPort.loading(
      availablePorts: state.availablePorts,
      connectedDevice: state.connectedDevice,
      port: state.port,
      lastCommand: PORT_COMMANDS.recheck,
    );

    // 2. 재시도 타이머 설정 (장치로부터 응답이 없을 경우 대비)
    Future.delayed(Duration(seconds: Config.instance.isDebugMode ? 5 : 10), () {
      // 10초 후에도 여전히 lastCommand가 recheck라면 응답을 못 받은 것임
      if (state.lastCommand == PORT_COMMANDS.recheck) {
        // showScafold("No response for 'recheck', retrying...");
        print("No response for 'recheck', retrying...");

        recheck(); // 자기 자신을 다시 호출하여 다시 명령 전송
      }
    });

    // 3. 장치(STM32)에 'recheck' 명령어 실제 전송
    return await writeToPort(PORT_COMMANDS.recheck);
  }

  Future<void> sendPhoneNumber(String phoneNumber) async {
    return await writeToPortPhone(
      PORT_COMMANDS.getValidPhoneCommand(phoneNumber),
    );
  }

  Future<void> sendRFIDNumber(String uid) async {
    return await writeToPortRFID(PORT_COMMANDS.getValidPhoneCommand(uid));
  }

  /// [DEBUG] 특정 응답을 받은 것처럼 시뮬레이션
  void listenDebug(String data) {
    // 1. 디버그용 데이터를 실제 수신 버퍼에 추가합니다.
    _receiveBuffer.write(data);
    // showScafold(
    //   "Debug data injected: $data (Buffer: ${_receiveBuffer.toString()})",
    // );

    // 2. 실제 데이터가 들어왔을 때와 동일한 버퍼 처리 로직을 호출
    _processBuffer();
  }

  void writeDebug(String msg) {
    // 1. 디버그 모드가 아니거나, 포트가 연결되지 않았으면 아무것도 하지 않음
    if (!Config.instance.isDebugMode) {
      print("writeDebug is only available in debug mode.");
      return;
    }
    // if (state is! UIStateUsbPortConnected && state.port == null) {
    //   showScafold("Debug Write Failed: Port not connected.");
    //   print("Debug Write Failed: Port not connected.");
    //   return;
    // }
    // 2. 메시지에 '#' 종료 문자가 없으면 추가
    String commandToSend = msg.endsWith('#') ? msg : '$msg#';

    // 3. 문자열을 Uint8List로 변환
    final dataToSend = Uint8List.fromList(commandToSend.codeUnits);

    // 4. 실제 포트로 데이터를 기록
    write(dataToSend);
  }

  void showScafold(String data) {
    if (Config.instance.isDebugMode) {
      Fluttertoast.showToast(
        msg: data,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _processBuffer() {
    // 버퍼에 종료 문자가 포함되어 있는 동안 계속 반복
    while (_receiveBuffer.toString().contains(_terminator)) {
      final bufferString = _receiveBuffer.toString();
      final messageEndIndex = bufferString.indexOf(_terminator);

      // 4. 종료 문자까지의 완전한 메시지를 추출
      final fullMessage = bufferString.substring(0, messageEndIndex);
      print("Complete message parsed: $fullMessage");

      // 5. 추출된 메시지를 처리 로직으로 전달
      listenByPort(fullMessage);

      // 6. 처리된 메시지와 종료 문자를 버퍼에서 제거
      // substring(messageEndIndex + 1)을 통해 버퍼의 나머지 부분을 유지
      final remaining = bufferString.substring(messageEndIndex + 1);
      _receiveBuffer.clear();
      _receiveBuffer.write(remaining);
    }
  }

  // void write(Uint8List dataToSend) {
  //   final String dataAsString = String.fromCharCodes(dataToSend);
  //   // showScafold("Write to port: $dataAsString");
  //   print("write to port: $dataAsString");
  //   state.port?.write(dataToSend);
  // }

  void write(Uint8List dataToSend) {
    if (state.port == null || !state.port!.isOpen) {
      print("Error: 포트가 열려있지 않습니다.");
      return;
    }

    try {
      // Windows에서 쓰기 성능 향상을 위한 설정
      if (Platform.isWindows) {
        // 1. 전송 전 출력 버퍼를 비웁니다.
        state.port!.flush();
      }

      final int result = state.port!.write(dataToSend);

      if (result < dataToSend.length) {
        print("Warning: 데이터가 일부만 전송되었습니다 ($result / ${dataToSend.length})");
      } else {
        print("Write Success: ${String.fromCharCodes(dataToSend)}");
      }
    } catch (e) {
      print("Write Exception: $e");
      _handleDisconnection(); // 에러 발생 시 안전하게 끊고 재연결 로직으로
    }
  }

  //Loading 등이면 초기화 처리 진행
  void initPortState() {
    if (state.connectedDevice == null) {
      state = UIStateUsbPort.init(
        availablePorts: state.availablePorts,
        connectedDevice: state.connectedDevice,
        port: state.port,
        lastCommand: null,
      );
      return;
    }

    state = UIStateUsbPort.connected(
      availablePorts: state.availablePorts,
      connectedDevice: state.connectedDevice!,
      port: state.port!,
      lastCommand: null,
    );
  }
}
