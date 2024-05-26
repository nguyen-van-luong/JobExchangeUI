import 'dart:async';
import 'package:dio/dio.dart';
import 'package:untitled1/dtos/register_employer.dart';
import 'package:untitled1/dtos/register_student.dart';

import '../api_config.dart';

class AuthRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.authEndpoint}";

  AuthRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
  // Phương thức để thực hiện đăng nhập
  Future<Response<dynamic>> loginUser({required String username, required String password}) async {
    return dio.post("/signin", data: {
      'username': username,
      'password': password,
    });
  }

  Future<Response<dynamic>> registerEmployer(RegisterEmployer registerEmployer) async {
    return dio.post(
      "/signup/employer",
      data: registerEmployer.toJson(),
    );
  }

  Future<Response<dynamic>> registerStudent(RegisterStudent registerStudent) async {
    return dio.post(
      "/signup/student",
      data: registerStudent.toJson(),
    );
  }

}
