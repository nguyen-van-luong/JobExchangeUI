import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:untitled1/dtos/application_dto.dart';
import 'package:untitled1/ui/views/employer/blocs/application/application_bloc.dart';

import '../api_config.dart';
import '../models/application.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class ApplicationRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.applicationEndpoint}";

  ApplicationRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
  Future<Response<dynamic>> submit({required List<int> cvIds, required int jobId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/submit/$jobId", data: jsonEncode(cvIds));
  }

  Future<Response<dynamic>> findByStudentIdAndJobId({required int studentId,required String jobId}) async {
    return dio.get("/find/$studentId/$jobId");
  }

  Future<Response<dynamic>> deleteApplication({required String cvId, required String jobId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/delete/$cvId/$jobId");
  }

  Future<Response<dynamic>> getSearch({
    required String? title,
    required String? status,
    required int page,
    int? limit}) async {
    String param = "";
    if(title != null && title.isNotEmpty)
      param += "title=$title&";
    if(status != null && status.isNotEmpty)
      param += "status=$status&";
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get(
        '/search?${param}page=$page&limit=${limit ?? 10}');
  }

  Future<Response<dynamic>> deleteList({required List<ApplicationDto> applicationDtos}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    List<Map<String, dynamic>> jsonList = applicationDtos.map((app) => app.toJson()).toList();

    return dio.delete("/delete", data: jsonEncode(jsonList));
  }

  Future<Response<dynamic>> update({required ApplicationDto applicationDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/update", data: applicationDto.toJson());
  }
}