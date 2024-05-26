import 'dart:convert';

import 'package:dio/dio.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class FCMRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.fcmTokenEndpoint}";

  FCMRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required String token}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: jsonEncode(token));
  }

  Future<Response<dynamic>> delete({required String token}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.delete("/delete", data: jsonEncode(token));
  }

}