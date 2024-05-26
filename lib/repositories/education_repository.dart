import 'package:dio/dio.dart';
import 'package:untitled1/dtos/activity_dto.dart';
import 'package:untitled1/dtos/education_dto.dart';
import 'package:untitled1/models/activity.dart';
import 'package:untitled1/models/education.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class EducationRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.educationEndpoint}";

  EducationRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required EducationDto educationDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: educationDto.toJson());
  }

  Future<Response<dynamic>> update(Education education) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: education.toJson(),
    );
  }

  Future<Response<dynamic>> delete(int id) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.delete("/delete/$id");
  }

  Future<Response<dynamic>> getByStudent() async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("/find");
  }

}