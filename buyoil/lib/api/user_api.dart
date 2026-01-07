import 'package:dio/dio.dart';

class UserApi {
  final Dio dio;

  UserApi(this.dio);

  Future<Response> createUser(Map<String, dynamic> data) {
    return dio.post(
      '/user',
      data: data,
    );
  }
}
