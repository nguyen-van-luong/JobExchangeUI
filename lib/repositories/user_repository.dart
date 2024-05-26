import 'dart:async';

import 'package:dio/dio.dart';

import '../api_config.dart';

class UserRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.usersEndpoint}";

  UserRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getUser(String username) async {
    return dio.get("/$username");
  }

  Future<Response<dynamic>> getTagCounts(String username) async {
    return dio.get("/$username/tags");
  }

  Future<Response<dynamic>> getStats(String username) async {
    return dio.get("/stats/$username");
  }
}
