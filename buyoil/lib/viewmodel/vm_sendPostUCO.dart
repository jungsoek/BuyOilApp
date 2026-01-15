import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<bool> fetchPostUCO(String measuredData) async {
  print('[fetchPostUCO] raw: $measuredData');

  try {
    final Map<String, dynamic> payload = jsonDecode(measuredData);
    final String number = payload['phoneNumber'] ?? '';

    if (number.length == 11) {
      final response = await http.post(
        Uri.parse('https://api.admin.bi-oil.app/postuco'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phoneNumber": number,
          "rfID": "",
          "countryDialCode": payload["countryDialCode"],
          "machineId": payload["machineId"],
          "oil": (payload["oil"] as num).toDouble(),
          "water": (payload["water"] as num).toDouble(),
        }),
      ).timeout(const Duration(seconds: 120));

      return response.statusCode == 200 || response.statusCode == 201;
    }

    if (number.length == 10) {
      final response = await http.post(
        Uri.parse('https://api.admin.bi-oil.app/postuco'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phoneNumber": "",
          "rfID": number,
          "countryDialCode": payload["countryDialCode"],
          "machineId": payload["machineId"],
          "oil": (payload["oil"] as num).toDouble(),
          "water": (payload["water"] as num).toDouble(),
        }),
      ).timeout(const Duration(seconds: 120));

      return response.statusCode == 200 || response.statusCode == 201;
    }

    // 여기로 오면 잘못된 Number
    debugPrint('[fetchPostUCO] invalid phoneNumber length');
    return false;

  } catch (e, stack) {
    debugPrint('[fetchPostUCO] error: $e');
    debugPrintStack(stackTrace: stack);
    return false;
  }
}

Future<bool> fetchPostUCO_() async {
  try {
    final response = await http
        .post(
      Uri.parse('https://api.admin.bi-oil.app/postuco'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "phoneNumber": "01011111111",
        "countryDialCode": "+82",
        "machineId": "testmachine",
        "oil": 12.34,
        "water": 5.67,
      }),
    )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('[fetchPostUCO] success: $data');
      return true;
    }

    print('[fetchPostUCO] status: ${response.statusCode}');
    return false;
  } catch (e, stack) {
    debugPrint('[fetchPostUCO] error: $e');
    debugPrintStack(stackTrace: stack);
    return false;
  }
}
