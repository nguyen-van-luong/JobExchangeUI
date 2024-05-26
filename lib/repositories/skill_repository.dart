import 'package:dio/dio.dart';
import 'package:untitled1/dtos/skill_dto.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class SkillRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.skillEndpoint}";

  SkillRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required SkillDto skillDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: skillDto.toJson());
  }

  Future<Response<dynamic>> update(SkillDto skillDto) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: skillDto.toJson(),
    );
  }

  Future<Response<dynamic>> delete(int id) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.delete("/delete/$id");
  }

  Future<Response<dynamic>> getAll() async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("");
  }

}