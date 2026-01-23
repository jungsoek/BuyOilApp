import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../model/user_request.dart';
import '../repository/user_repository.dart';

Future<UserResult?> fetchUser(String number) async {
  // 조건을 만족하지 않을 경우 미리 반환 (Early Return)
  if (number.length != 11 && number.length != 10) {
    return null;
  }

  print('vm_sendUser.dart - fetchData: $number');

  try {
    // 조건에 따른 바디 데이터 설정
    final Map<String, String> requestBody = number.length == 11
        ? {
      "phoneNumber": number,
      "rfID": "",
      "countryDialCode": "+82",
      "machineId": "testmachine",
    }
        : {
      "phoneNumber": "",
      "rfID": number,
      "countryDialCode": "",
      "machineId": "testmachine"
    };

    final response = await http
        .post(
      Uri.parse('https://api.admin.bi-oil.app/identity'),
      body: requestBody,
    )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      print('vm_sendUser.dart - fetchUser() return : ${data}');

      // 이 UserResult는 반드시 model/user_request.dart에 정의된 것이어야 함
      return UserResult.fromJson(data);
    }

    print('Error Status: ${response.statusCode}');
    return null;

  } catch (e) {
    print('Error Exception: $e');
    return null;
  }
}

class UserResult {
  final String userId;
  final bool driver;

  UserResult({
    required this.userId,
    required this.driver,
  });

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      userId: json['userId'],
      driver: json['driver'],
    );
  }
}

Future<bool> checkRealInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('인터넷 연결 성공(Ping 성공)');
      return true;
    }
  } on SocketException catch(_) {
    print('인터넷 연결 실패(서버에 도달할 수 없음)');
    return false;
  }

  return false;
}

