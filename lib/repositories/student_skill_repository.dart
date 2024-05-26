import 'package:dio/dio.dart';
import 'package:untitled1/dtos/student_skill_dto.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class StudentSkillRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.studentSkillEndpoint}";

  StudentSkillRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required StudentSkillDto skillDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: skillDto.toJson());
  }

  Future<Response<dynamic>> update(StudentSkillDto skillDto) async {
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

  Future<Response<dynamic>> getByStudent() async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("/find");
  }

}