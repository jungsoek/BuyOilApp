import 'dart:async';
import 'dart:typed_data';

import 'package:buyoil/common/app_commands.dart';
import 'package:buyoil/common/utils/show_toast.dart';
import 'package:buyoil/common/utils/toast/toast_provider.dart';
import 'package:buyoil/model/ui_state_usb_port.dart';
import 'package:buyoil/router.dart';
import 'package:buyoil/viewmodel/vm_sendPostPer.dart';
import 'package:buyoil/viewmodel/vm_sendPostUCO.dart';
import 'package:buyoil/viewmodel/vm_step1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:buyoil/viewmodel/vm_sendUser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:usb_serial/usb_serial.dart';

import '../common/app_strings.dart';
import '../config.dart';

part 'vm_serial_port.g.dart';

@Riverpod(keepAlive: true)
class SerialPortVM extends _$SerialPortVM {
  StreamSubscription<Uint8List>? _subscription;

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
    // ViewModel이 처음 생성될 때 재시도 카운터 초기화
    _reconnectAttempts = 0;

    // Riverpod 2.0에서는 @dispose 어노테이션을 사용하거나,
    // ref.onDispose를 사용하여 리소스를 정리
    ref.onDispose(() {
      _subscription?.cancel();
      try {
        state.port?.close();
      } catch (e) {}
      _inactivityTimer?.cancel();
      _reconnectTimer?.cancel(); // 재연결 타이머도 취소
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
        showScafold(AppStrings.trySleep);
        writeToPort(PORT_COMMANDS.sleep);
      },
    );
  }

  _init() async {
    connectPort();
  }

  Future<void> connectPort({BuildContext? context}) async {
    // 1. 기존 연결 및 버퍼 정리
    _subscription?.cancel(); // 이전 구독이 있다면 취소
    try {
      state.port?.close(); // 이전 포트가 있다면 닫기
    } catch (e) {}
    _receiveBuffer.clear();

    // 재연결 시도가 아닐 경우에만 init() 상태로 변경 (연결 끊김 메시지 유지를 위해)
    if (_reconnectAttempts == 0) {
      state = UIStateUsbPort.init();
    }

    List<UsbDevice> devices = await UsbSerial.listDevices();

    state = state.copyWith(availablePorts: devices);

    String printString = "";
    devices.forEach((dv) {
      printString += dv.deviceName;
      printString += "\n";
    });
    showScafold("devices[${devices.length}\n(${printString})");

    if (devices.isEmpty) {
      showScafold(AppStrings.noConnectableDevicesFound);
      state = UIStateUsbPort.error(
        errorMsg: AppStrings.noConnectableDevicesFound,
      );
      return;
    }

    UsbDevice? deviceToConnect;

    try {
      deviceToConnect = devices.firstWhere(
        (d) =>
            (d.productName?.toLowerCase().contains("stm32") ?? false) ||
            (d.productName?.toLowerCase().contains("usb serial") ?? false),
      );
      showScafold("Auto-selecting device: ${deviceToConnect.productName}");
      print("Auto-selecting device: ${deviceToConnect.productName}");
    } catch (e) {
      // firstWhere가 장치를 찾지 못하면 에러를 발생시키므로, 여기서 null 처리
      deviceToConnect = null;
      print("No auto-selectable device found. Proceeding to manual selection.");
    }

    if (deviceToConnect == null) {
      if (devices.length > 1 && context != null && context.mounted) {
        // 장치가 여러 개일 경우 선택 팝업 표시
        deviceToConnect = await showDialog<UsbDevice>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Select Device'),
              content: SizedBox(
                width: 350,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: devices.length,
                  itemBuilder: (BuildContext _, int index) {
                    final device = devices[index];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      title: Text(
                        "${index + 1}/${devices.length} ${device.productName ?? 'Unknown Device'}",
                      ),
                      subtitle: Text('VID: ${device.vid}, PID: ${device.pid}'),
                      onTap: () {
                        Navigator.of(dialogContext).pop(device);
                      },
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );

        if (deviceToConnect == null) {
          showScafold(AppStrings.deviceSelectionCanceled);
          state = UIStateUsbPort.error(
            errorMsg: AppStrings.deviceSelectionCanceled,
          );
          return;
        }
      } else {
        // 장치가 하나뿐인 경우 자동으로 첫 번째 장치 선택
        deviceToConnect = devices.first;
      }
    }

    showScafold(
      "${AppStrings.tryToConnect}: ${deviceToConnect.productName ?? deviceToConnect.deviceName}",
    );

    /// 디버그 기기 선택 시, 별도 동작 진행
    if (Config.instance.isDebugMode &&
        deviceToConnect.productName == "Select This Debug Device For Test") {
      _connectionAttemptIndex = 0;
      UsbPort port = UsbPort("test port");
      // --- (포트 설정 및 listen 로직은 기존과 동일) ---
      await port.setDTR(true);
      await port.setRTS(true);
      await port.setPortParameters(
        115200,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      _subscription = port.inputStream!.listen(
        (Uint8List data) {
          if (_reconnectAttempts > 0) {
            showScafold("Device reconnected successfully!");
            _reconnectAttempts = 0; // 성공했으므로 재시도 카운터 초기화
            _reconnectTimer?.cancel();
          }

          final receivedString = String.fromCharCodes(data);
          _receiveBuffer.write(receivedString);
          showScafold(
            "Received chunk: $receivedString (Buffer: ${_receiveBuffer.toString()})",
          );

          // 3. 버퍼에 종료 문자가 있는지 확인하고, 있으면 처리
          _processBuffer();
        },
        onError: (error) {
          print("Port stream error: $error. Attempting to reconnect...");
          showScafold("Connection error. Trying to reconnect...");
          state = UIStateUsbPort.error(errorMsg: "Connection error: $error");
          _handleDisconnection();
        },
        onDone: () {
          print("Port connection lost (onDone). Attempting to reconnect...");
          showScafold("Connection lost. Trying to reconnect...");
          state = UIStateUsbPort.error(
            errorMsg: "Connection lost. Retrying...",
          );
          _handleDisconnection();
        },
      );

      state = UIStateUsbPort.connected(
        port: port,
        connectedDevice: deviceToConnect,
      );
      final connectedDeviceName =
          deviceToConnect.productName ?? deviceToConnect.deviceName;
      final toastMessage =
          "Connection Succeeded: $connectedDeviceName (VID:${deviceToConnect.vid}, PID:${deviceToConnect.pid})";

      showScafold(toastMessage);
      _resetInactivityTimer();
      return;
    }

    // 3. 포트 생성 및 연결 (기존 로직과 동일)
    UsbPort? port = await deviceToConnect.create();
    if (port == null) {
      state = UIStateUsbPort.error(errorMsg: AppStrings.cannotCreatePort);
      showScafold(AppStrings.cannotCreatePort);
      _handleDisconnection(); // 포트 생성 실패 시에도 재연결 시도
      return;
    }

    bool openResult = await port.open();
    if (!openResult) {
      state = UIStateUsbPort.error(errorMsg: AppStrings.cannotOpenPort);
      _handleDisconnection(); // 포트 열기 실패 시에도 재연결 시도
      showScafold(AppStrings.cannotOpenPort);
      return;
    }

    // 연결 성공 시 재시도 카운터 초기화
    _connectionAttemptIndex = 0;
    _reconnectAttempts = 0; // 재연결 성공했으므로 카운터 초기화
    _reconnectTimer?.cancel();

    // --- (포트 설정 및 listen 로직은 기존과 동일) ---
    await port.setDTR(true);
    await port.setRTS(true);
    await port.setPortParameters(
      115200,
      UsbPort.DATABITS_8,
      UsbPort.STOPBITS_1,
      UsbPort.PARITY_NONE,
    );

    _subscription = port.inputStream!.listen(
      (Uint8List data) {
        // 데이터 수신 시 재연결 상태였다면 완전한 성공으로 간주
        if (_reconnectAttempts > 0 || _reconnectTimer?.isActive == true) {
          showScafold("Device reconnected successfully!");
          print("Device reconnected successfully!");
          _reconnectAttempts = 0;
          _reconnectTimer?.cancel();
        }

        final receivedString = String.fromCharCodes(data);
        _receiveBuffer.write(receivedString);
        showScafold(
          "Received chunk: $receivedString (Buffer: ${_receiveBuffer.toString()})",
        );
        // 3. 버퍼에 종료 문자가 있는지 확인하고, 있으면 처리
        _processBuffer();
      },
      onDone: () {
        print("Port connection lost (onDone).");
        state = UIStateUsbPort.error(errorMsg: "Connection lost. Retrying...");
        _handleDisconnection();
      },
      onError: (error) {
        print("Port stream error: $error.");
        state = UIStateUsbPort.error(errorMsg: "Connection error: $error");
        _handleDisconnection();
      },
    );
    state = UIStateUsbPort.connected(
      port: port,
      connectedDevice: deviceToConnect,
    );
    final connectedDeviceName =
        deviceToConnect.productName ?? deviceToConnect.deviceName;
    final toastMessage =
        "Connection Succeeded: $connectedDeviceName (VID:${deviceToConnect.vid}, PID:${deviceToConnect.pid})";

    showScafold(toastMessage);
    _resetInactivityTimer(); // <--- 4. 연결 성공 시 타이머 시작
  }

  /// 연결이 끊겼을 때 호출되는 공통 핸들러
  void _handleDisconnection() {
    // 기존 리소스 정리
    _subscription?.cancel();
    _subscription = null;
    try {
      state.port?.close();
    } catch (e) {
      print("Error closing port during disconnection: $e");
    }

    // 재연결 시도 시작
    _attemptReconnect();
  }

  /// 재연결을 시도하는 함수
  void _attemptReconnect() {
    // 이미 재연결 타이머가 동작 중이면 중복 실행 방지
    if (_reconnectTimer?.isActive ?? false) return;

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      print("Max reconnect attempts reached. Stopping reconnection.");
      showScafold("Failed to reconnect. Please check the connection.");
      state = UIStateUsbPort.error(
        errorMsg:
            "Failed to reconnect. Please check the cable and restart the app.",
      );
      _reconnectAttempts = 0; // 다음 수동 연결을 위해 초기화
      return;
    }

    _reconnectAttempts++;
    print(
      "Attempting to reconnect... ($_reconnectAttempts/$_maxReconnectAttempts)",
    );
    showScafold("Reconnection attempt $_reconnectAttempts...");

    // 3초 후에 `connectPort` 함수를 다시 호출하여 연결 시도
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      print("Executing reconnect via connectPort()");
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
      String packet = "${command.command}#";
      final dataToSend = Uint8List.fromList(packet.codeUnits);
      write(dataToSend);
      return;
    }

    if (state is UIStateUsbPortConnected) {
      state = state.copyWith(lastCommand: command);
      String packet = "${command.command}#";
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

    final fetchResult = await fetchUser(cleanNumber);

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

    print('[POST_UCO][RAW] $ucoJson');

    if (!ucoJson.startsWith('{') || !ucoJson.endsWith('}')) {
      print('[POST_UCO] Invalid JSON format');
      return;
    }

    final fetchResult = await fetchPostUCO(ucoJson);

    if (fetchResult != null) {
      print('[POST_UCO] Fetch Success');
      state = state.copyWith(
        lastCommand: PORT_COMMANDS.postper,
      );
      listenByPort(PORT_RESPONSES.ok.response);
    }
  }

  Future<void> writeToPortPostPer(
      String measuredData, {
        BuildContext? context,
      }) async {
    _resetInactivityTimer();

    print("[POST_PER][RAW] $measuredData");

    // JSON 유효성 최소 검증
    if (!measuredData.startsWith('{') || !measuredData.endsWith('}')) {
      print('[POST_PER] Invalid JSON format');
      return;
    }

    // 서버 전송 (STM32와 무관)
    final fetchResult = await fetchPostPer(measuredData);

    if (fetchResult != null) {
      print('[POST_PER] Fetch Success');

      // 서버 성공 → UI 상태만 갱신
      state = state.copyWith(
        lastCommand: PORT_COMMANDS.postper,
      );
      listenByPort(PORT_RESPONSES.ok.response);
    }
  }


  // 포트에서 받은 값 처리
  // 직전 명령에 따라서 동작 별도 처리
  void listenByPort(String receivedString) {
    if(!receivedString.startsWith(AppCommands.prefixAnswer)) {
      showScafold("Prefix String is not [ANS]");
      return ;
    }
    showScafold("[${state.lastCommand}]listenByPort: $receivedString#\n_receiveBuffer:${_receiveBuffer}");
    print("[DEBUG] lastCommand  : ${state.lastCommand}");
    print("[DEBUG] listenByPort : $receivedString");
    // 최초 화면에서
    if(state.lastCommand == PORT_COMMANDS.handshake) {
      // OK 받으면
      if(receivedString == PORT_RESPONSES.ok.response) {
        // 전화번호 입력 페이지 이동
        ref.watch(routerProvider).goNamed(RouteGroup.Step1.name);
      } else if(receivedString == PORT_RESPONSES.fail.response) {
        // 아니면 기본 화면 유지
        ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      } else if(receivedString == PORT_RESPONSES.full.response) {
        ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
        // 1. 5초간 팝업 띄우기
        ref.read(toastProvider.notifier).showToast(AppStrings.fullContainer, duration: Duration(seconds: 5));
      }
    }

    if (receivedString == PORT_RESPONSES.fail.response) {
      state = state.copyWith(lastCommand: null);
      // 2. 첫 페이지(Splash)로 이동
      ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      // 1. 5초간 팝업 띄우기
      ref.read(toastProvider.notifier).showToast(AppStrings.systemError, duration: Duration(seconds: 5));
      return;
    }

    // [ANS]STM_SLEEP# 응답을 받으면
    if (receivedString == PORT_RESPONSES.stmSleep.response) {
      showScafold("Received STM_SLEEP. Going to Splash.");
      // 스플래시 화면으로 이동
      ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      // lastCommand를 초기화하여 추가 동작 방지
      state = state.copyWith(lastCommand: null);
      return; // 이 응답 처리는 여기서 종료
    }

    // 전화번호 send 응답이
    if(state.lastCommand == PORT_COMMANDS.cmdPhone || state.lastCommand == PORT_COMMANDS.cmdRFID) {
      // OK 받으면
      if(receivedString == PORT_RESPONSES.ok.response) {
        // 성공 시 실패 카운터 초기화
        state = state.copyWith(resetFailCount: 0);

        // page4(Step2) 오픈 화면 이동
        ref.watch(routerProvider).goNamed(RouteGroup.Step2.name);
      } else if(receivedString == PORT_RESPONSES.open.response) {
        // 성공 시 실패 카운터 초기화
        state = state.copyWith(resetFailCount: 0);
        // Opening Door Screen 이동
        ref.watch(routerProvider).goNamed(RouteGroup.OpeningDoor.name);
      } else if(receivedString == PORT_RESPONSES.fail.response) {
        // todo 변경사항 확인하기
        ref.read(step1Provider.notifier).showErrorToast();
      } else if(receivedString == PORT_RESPONSES.reject.response) {
        final newFailCount = (state.resetFailCount ?? 0) + 1;
        state = state.copyWith(resetFailCount: newFailCount);
        if (newFailCount >= 5) {
          // 1. 5회 실패: 첫 페이지로 복귀
          ref.read(toastProvider.notifier).showToast(
              AppStrings.accessDenied,
              duration: Duration(seconds: 5));
          ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
          // 상태 초기화
          state = state.copyWith(lastCommand: null, resetFailCount: 0);
        } else {
          // 2. 5회 미만 실패: 팝업 메시지 표시 (페이지는 그대로 유지)
          ref.read(toastProvider.notifier).showToast(
              AppStrings.accessDenied,
              duration: Duration(seconds: 3)
          );
        }
        // todo 변경사항 확인하기
      } else if(receivedString == PORT_RESPONSES.notAuth.response) {
        // *return “NOTAUTH” -> Please shows the proper driver code
        // TODO
      } else if(receivedString == PORT_RESPONSES.driverTrue.response) {
        // send "[CMD]OPENB#" and shows driver's page.
        writeToPort(PORT_COMMANDS.openB).whenComplete(() {
          goToDriverPage();
        });
      } else if(receivedString == PORT_RESPONSES.driverFalse.response) {
        ref.read(toastProvider.notifier).showToast(AppStrings.notAuthorized);
        // send "[CMD]SLEEP#" and shows not authorized.
        writeToPort(PORT_COMMANDS.sleep);
      }
    }

    // Open 명령어
    if(state.lastCommand == PORT_COMMANDS.open) {
      // ok 응답 -> Close 화면 이동
      if(receivedString == PORT_RESPONSES.ok.response) {
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
        showScafold("Received OK for 'postper', now sending 'postData'.");
        // poster -> postData 로 이어지므로 마지막 명령어 자체 업데이트
        state = state.copyWith(lastCommand: PORT_COMMANDS.postData);
        okayNextStep(); // postData를 보내는 전용 함수 호출
        return;
      }
    }

    if(state.lastCommand == PORT_COMMANDS.postData) {
      if (receivedString == PORT_RESPONSES.ok.response) {
        // 2. postData에 대한 응답을 받으면 lastCommand를 초기화하여 재시도 타이머를 멈춤
        state = state.copyWith(lastCommand: null);
        // 2-1. 응답이 'OK'이면 모든 과정이 성공했으므로 스플래시 화면으로 이동
        print("Received OK for 'postData'. Process complete.");
        showScafold("Received OK for 'postData'. Process complete.");
        ref.watch(routerProvider).goNamed(RouteGroup.Splash.name);
      }
    }

    // Close 명령어
    if(state.lastCommand == PORT_COMMANDS.close) {
      // O, W, E 포맷이면
      if(formatRegex.hasMatch(receivedString)) {
        state = state.copyWith(lastCommand: null);
        (double oil, double water) res = AppCommands.returnOilWaterFormat(receivedString);

        // 초기화 후 Step4화면 재실행
        if(state.connectedDevice != null && state.port != null) {
          state = UIStateUsbPortConnected(
            availablePorts: state.availablePorts,
            connectedDevice: state.connectedDevice!,
            port: state.port!,
            lastCommand: null,
          );
        }

        ref.read(routerProvider).goNamed(RouteGroup.Step4.name, queryParameters: {
          "oil": "${res.$1}",
          "water": "${res.$2}",
        });
      }
    }

    if(state.lastCommand == PORT_COMMANDS.recheck) {
      // O, W, E 포맷이면
      if(formatRegex.hasMatch(receivedString)) {
        // 초기화 후 Step4화면 재실행
        state = UIStateUsbPortConnected(
          availablePorts: state.availablePorts,
          connectedDevice: state.connectedDevice,
          port: state.port,
          lastCommand: null,
        );

        (double oil, double water) res = AppCommands.returnOilWaterFormat(receivedString);
        // 초기화 후 Step4화면 재실행
        print("recheck success: ${state.connectedDevice}/ ${state.port}");
        ref.read(routerProvider).goNamed(RouteGroup.Step4.name, queryParameters: {
          "oil": "${res.$1}",
          "water": "${res.$2}",
        });
      }
    }

    // ok 명령 받은 경우 lastCommand 초기화
    if(receivedString == PORT_RESPONSES.ok.response) {
      if(state.lastCommand == PORT_COMMANDS.postData || state.lastCommand == PORT_COMMANDS.postper || state.lastCommand == PORT_COMMANDS.recheck) {
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
    // 30초 이내에 ok 안오면 재시도
    Future.delayed(Duration(seconds: Config.instance.isDebugMode ? 5 : 30), () {
      if (state.lastCommand == PORT_COMMANDS.open) {
        open();
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
    // 1. 서버 전송 (UCO 데이터 업로드)
    // 측정값이 전달되었다면 JSON으로 변환하여 서버에 먼저 전송
    if (oil != null && water != null) {
      final String ucoJson = '{"oil": $oil, "water": $water}';
      // 비동기로 실행하되, 서버 응답을 기다리지 않고 장치 명령을 진행할 수도 있다.
      writeToPortPostUCO(ucoJson);
    }

    // 2. 'postper' 명령에 대한 재시도 로직 설정
    Future.delayed(Duration(seconds: Config.instance.isDebugMode ? 5 : 10), () {
      if (state.lastCommand == PORT_COMMANDS.postper || state.lastCommand == PORT_COMMANDS.postData) {
        showScafold("No response, retrying okay process...");
        okay(); // 재시도 시에는 파라미터 없이 호출하여 장치 명령만 반복하게 할 수 있음
      }
    });

    // 3. 장치(STM32)에 'postper' 명령어 전송
    await writeToPort(PORT_COMMANDS.postper);

    // 4. 로딩 상태로 변경
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
        showScafold("No response for 'postData', retrying...");
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
        showScafold("No response for 'recheck', retrying...");
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
    return await writeToPortRFID(uid);
  }

  /// [DEBUG] 특정 응답을 받은 것처럼 시뮬레이션
  void listenDebug(String data) {
    // 1. 디버그용 데이터를 실제 수신 버퍼에 추가합니다.
    _receiveBuffer.write(data);
    showScafold(
      "Debug data injected: $data (Buffer: ${_receiveBuffer.toString()})",
    );

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

  void write(Uint8List dataToSend) {
    final String dataAsString = String.fromCharCodes(dataToSend);
    showScafold("Write to port: $dataAsString");
    print("write to port: $dataAsString");
    state.port?.write(dataToSend);
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
