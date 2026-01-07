import 'dart:convert';
import 'package:http/http.dart' as http;

Future<IdentityResult?> fetchData(String uid) async {
  try {
    final response = await http
        .post(
      Uri.parse('https://api.admin.bi-oil.app/identity'),
      body: {
        "phoneNumber": uid,
        "rfidNumber": uid,
        "countryDialCode": "+82",
        "machineId": "testmachine"
      },
    ).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return IdentityResult.fromJson(data);
    }

    return null;
  } catch (e) {
    return null;
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
