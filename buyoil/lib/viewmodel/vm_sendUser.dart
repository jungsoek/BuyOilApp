import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../model/user_request.dart';
import '../repository/user_repository.dart';

Future<IdentityResult?> fetchUser(String number) async {

  if(number.length == 11) {
    print('vm_sendUser.dart - fetchData(String number) ? number : ${number}');
    try {
      final response = await http
          .post(
        Uri.parse('https://api.admin.bi-oil.app/identity'),
        body: {
          "phoneNumber": number,
          "rfID": "",
          "countryDialCode": "+82",
          "machineId": "testmachine",
        },
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return IdentityResult.fromJson(data);
      }

      print('${response.statusCode}');

      return null;
    } catch (e) {
      return null;
    }
  } else if(number.length == 10) {
    print('vm_sendUser.dart - fetchData(String number) ? number : ${number}');
    try {
      final response = await http
          .post(
        Uri.parse('https://api.admin.bi-oil.app/identity'),
        body: {
          "phoneNumber": "",
          "rfID": number,
          "countryDialCode": "",
          "machineId": "testmachine"
        },
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return IdentityResult.fromJson(data);
      }

      print('${response.statusCode}');

      return null;
    } catch (e) {
      return null;
    }
  }

}

class IdentityResult {
  final String userId;
  final bool driver;

  IdentityResult({
    required this.userId,
    required this.driver,
  });

  factory IdentityResult.fromJson(Map<String, dynamic> json) {
    return IdentityResult(
      userId: json['userId'],
      driver: json['driver'],
    );
  }
}

// MVVM 패턴으로 구조 변경 시 사용할 것
class UserViewModel extends ChangeNotifier {
  final UserRepository _repository;

  UserViewModel(this._repository);

  UserResult? _user;
  bool _isLoading = false;
  String? _error;

  UserResult? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUser(String number) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if(number.length == 11) {
        _user = await _repository.fetchUser(
          phoneNumber: number,
          rfid: "",
        );
      } else if(number.length == 10) {
        _user = await _repository.fetchUser(
          phoneNumber: "",
          rfid: number,
        );
      } else {
        _error = "Invalid input";
      }
    } catch(e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

}
