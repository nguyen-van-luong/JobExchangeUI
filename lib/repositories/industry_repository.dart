import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:untitled1/dtos/industry_dto.dart';

import '../api_config.dart';
import '../models/industry.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class IndustryRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.industryEndpoint}";

  IndustryRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getAll() async {
    return dio.get("");
  }

  Future<Response<dynamic>> getSearch({
    required String name,
    required int page,
    int? limit}) async {
    String param = "name=" + name ?? "";

    return dio.get(
        '/search?$param&page=$page&limit=${limit ?? pageSize}');
  }

  Future<Response<dynamic>> deleteList({required List<int> ids}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.delete("/delete", data: jsonEncode(ids));
  }

  Future<Response<dynamic>> update({required Industry industry}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/update", data: industry.toJson());
  }

  Future<Response<dynamic>> create({required IndustryDto industryDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/create", data: industryDto.toJson());
  }

}