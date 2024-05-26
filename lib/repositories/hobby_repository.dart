import 'package:dio/dio.dart';
import 'package:untitled1/dtos/hobby_dto.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class HobbyRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.hobbyEndpoint}";

  HobbyRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required HobbyDto hobbyDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: hobbyDto.toJson());
  }

  Future<Response<dynamic>> update(HobbyDto hobbyDto) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: hobbyDto.toJson(),
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