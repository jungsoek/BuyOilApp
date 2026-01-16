import 'dart:convert';
import 'package:http/http.dart' as http;
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
      // 이 UserResult는 반드시 model/user_request.dart에 정의된 것이어야 함
      return UserResult.fromJson(data);
    }

    print('Error Status: ${response.statusCode}');
    return null;

  } catch (e) {
    print('Error Exception: $e');
    return null;
  }

  // 모든 if문을 통과하지 못했을 경우를 위해 마지막에도 null 반환
  return null;
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

// MVVM 패턴으로 구조 변경 시 사용할 것
// class UserViewModel extends ChangeNotifier {
//   final UserRepository _repository;
//
//   UserViewModel(this._repository);
//
//   UserResult? _user;
//   bool _isLoading = false;
//   String? _error;
//
//   UserResult? get user => _user;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//
//   Future<void> fetchUser(String number) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       if(number.length == 11) {
//         _user = await _repository.fetchUser(
//           phoneNumber: number,
//           rfid: "",
//         );
//       } else if(number.length == 10) {
//         _user = await _repository.fetchUser(
//           phoneNumber: "",
//           rfid: number,
//         );
//       } else {
//         _error = "Invalid input";
//       }
//     } catch(e) {
//       _error = e.toString();
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
// }
