import 'package:dio/dio.dart';
import 'package:untitled1/dtos/experience_dto.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class ExperienceRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.experienceEndpoint}";

  ExperienceRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required ExperienceDto experienceDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: experienceDto.toJson());
  }

  Future<Response<dynamic>> update(ExperienceDto experienceDto) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: experienceDto.toJson(),
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