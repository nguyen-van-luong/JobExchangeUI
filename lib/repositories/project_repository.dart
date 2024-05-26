import 'package:dio/dio.dart';
import 'package:untitled1/dtos/project_dto.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class ProjectRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.projectEndpoint}";

  ProjectRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required ProjectDto projectDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: projectDto.toJson());
  }

  Future<Response<dynamic>> update(ProjectDto projectDto) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: projectDto.toJson(),
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