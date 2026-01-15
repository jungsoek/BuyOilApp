import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../model/user_request.dart';
import '../repository/user_repository.dart';

Future<bool> fetchPostPer(String measuredData) async {
  print('[fetchPostPer] raw: $measuredData');

  try {
    final Map<String, dynamic> payload = jsonDecode(measuredData);

    final response = await http
        .post(
      Uri.parse('https://api.admin.bi-oil.app/postcontainer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "machineId": payload["machineId"],
        "volume": (payload["volume"] as num).toDouble(),
        "battery": (payload["battery"] as num).toDouble(),
      }),
    )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('[fetchPostPer] success: $data');
      return true;
    }

    print('[fetchPostPer] status: ${response.statusCode}');
    return false;
  } catch (e, stack) {
    debugPrint('[fetchPostPer] error: $e');
    debugPrintStack(stackTrace: stack);
    return false;
  }
}


// DummyData Test
Future<bool> fetchPostPer_() async {

  try {
    final response = await http
        .post(
      Uri.parse('https://api.admin.bi-oil.app/postcontainer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "machineId": "testmachine",
        "volume": 50.123,
        "battery": 60.456,
      }),
    )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('[fetchPostPer] success: $data');
      return true;
    }

    print('[fetchPostPer] status: ${response.statusCode}');
    return false;
  } catch (e, stack) {
    debugPrint('[fetchPostPer] error: $e');
    debugPrintStack(stackTrace: stack);
    return false;
  }
}

