import 'dart:typed_data';

enum PORT_COMMANDS {
  close(AppCommands.cmdClose),
  handshake(AppCommands.cmdHandshake),
  open(AppCommands.cmdOpens),
  postper(AppCommands.cmdPostper),
  postData(AppCommands.cmdPostData),
  cmdPhone(AppCommands.cmdPhone),
  cmdRFID(AppCommands.cmdRFID),
  recheck(AppCommands.cmdClose),
  sleep(AppCommands.cmdSleep),
  driverTrue(AppCommands.returnDriverTrue),
  driverFalse(AppCommands.returnDriverFalse),
  openB(AppCommands.cmdOpenb),
  ;

  final String command;

  // enum 생성자
  const PORT_COMMANDS(this.command);

  Uint8List toUint8List() {
    return Uint8List.fromList(command.codeUnits);
  }

  static Uint8List toUint8ListByString(String command) {
    return Uint8List.fromList(command.codeUnits);
  }

  static String getValidPhoneCommand(String phone) {
    return "${AppCommands.validPhonePrefix}$phone${AppCommands.validPhoneSuffix}";
  }

  static String getValidRFIDCommand(String uid) {
    return "${AppCommands.validRFIDPrefix}$uid${AppCommands.validRFIDSuffix}";
  }
}

enum PORT_RESPONSES {
  // 각 enum 멤버는 AppCommands에 정의된 실제 응답 문자열을 값으로 가집니다.
  ok(AppCommands.returnOk),
  fail(AppCommands.returnFail),
  full(AppCommands.returnFull),
  reject(AppCommands.returnReject),
  open(AppCommands.returnOpen),
  notAuth(AppCommands.returnNotAuth),
  driverTrue(AppCommands.returnDriverTrue),
  driverFalse(AppCommands.returnDriverFalse),
  stmSleep(AppCommands.returnStmSleep),
  ;

  // enum이 실제 응답 문자열 값을 저장할 final 변수
  final String response;

  // enum 생성자
  const PORT_RESPONSES(this.response);

  /// 수신된 문자열(value)을 기반으로 일치하는 PORT_RESPONSES enum 멤버를 찾습니다.
  /// 일치하는 멤버가 없으면 null을 반환합니다.
  static PORT_RESPONSES? byValue(String value) {
    for (var resp in values) {
      if (resp.response == value) {
        return resp;
      }
    }
    return null;
  }
}

class AppCommands {
  static const String testMeasure = "[TEST]MEASURE";

  static const String cmdHandshake = "[CMD]HANDSHAKE";

  static const String cmdPhone = "[VALID]--ENDSTR";
  static const String cmdRFID = "[VALID]--ENDSTR";
  static const String validPhonePrefix = "[VALID]";
  static const String validPhoneSuffix = "ENDSTR";
  static const String validRFIDPrefix = "[VALID]";
  static const String validRFIDSuffix = "ENDSTR";
  static const String prefixPer = "[PER]";


  static const String cmdOpens = "[CMD]OPENS";
  static const String cmdClose = "[CMD]CLOSES";
  static const String cmdPostper = "[CMD]POSTPER";

  static const String cmdSleep = "[CMD]SLEEP";
  static const String cmdOpenb = "[CMD]OPENB";
  static const String cmdOpenv = "[CMD]OPENV";
  static const String cmdClosev = "[CMD]CLOSEV";
  static const String cmdOff = "[CMD]OFF";
  static const String cmdTest = "[TEST]";
  static const String cmdPostData = "[CMD]POSTDATA";
  static const String returnDriverTrue = "${prefixAnswer}DRIVER:TRUE";
  static const String returnDriverFalse = "${prefixAnswer}DRIVER:FALSE";
  static const String returnStmSleep = "${prefixAnswer}STM_SLEEP";

  static const String prefixAnswer = "[ANS]";
  static const String returnOk = "${prefixAnswer}OK";
  static const String returnFail = "${prefixAnswer}FAIL";
  static const String returnReject = "${prefixAnswer}REJECT";
  static const String returnOpen = "${prefixAnswer}OPEN";
  static const String returnNotAuth = "${prefixAnswer}NOTAUTH";
  static const String returnFull = "${prefixAnswer}FULL";

  // 정규식 수정: 끝에 #가 있을 수도 있고 없을 수도 있도록 처리
  static final RegExp regExp = RegExp(r"O(\d+(?:\.\d+)?)W(\d+(?:\.\d+)?).*#?$");

  static (double oil, double water) returnOilWaterFormat(String input) {
    double oil = 0.0;
    double water = 0.0;
    final Match? match = regExp.firstMatch(input);
    if (match != null && match.groupCount == 2) {
      String? oilString = match.group(1);
      String? waterString = match.group(2);

      print("Extracted oil string: $oilString"); // "7.89"
      print("Extracted water string: $waterString"); // "1.23"

      // 추출된 문자열을 double로 변환합니다. 변환 실패 시 null이 될 수 있으므로 tryParse 사용
      if (oilString != null) {
        oil = double.tryParse(oilString) ?? 0.0;
      }
      if (waterString != null) {
        water = double.tryParse(waterString) ?? 0.0;
      }
    }

    return (oil, water);
  }

}