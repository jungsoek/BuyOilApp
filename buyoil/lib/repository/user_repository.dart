
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_request.dart';

class UserRepository {
  static const _url = 'https://api.admin.bi-oil.app/identity';

  Future<UserResult?> fetchUser({
   required String phoneNumber,
   required String rfid,
}) async {
    try {
      final response = await http
          .post(
        Uri.parse(_url),
        body: {
          "phoneNUmber" : phoneNumber,
          "rfid" : rfid,
          "contryDialCode" : "+82",
          "machineId" : "testmachine",
        },
      ).timeout(const Duration(seconds: 5));

      if(response.statusCode == 200 || response.statusCode == 201) {
        return UserResult.fromJson(
          jsonDecode(response.body),
        );
      }

      print('HTTP Error : ${response.statusCode}');

      return null;
    } catch (e) {
      print('Network Error : $e');
      return null;
    }
  }
}