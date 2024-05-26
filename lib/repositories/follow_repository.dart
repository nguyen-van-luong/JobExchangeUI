import 'package:dio/dio.dart';

import '../api_config.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class FollowRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.followEndpoint}";

  FollowRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
  Future<Response<dynamic>> follow({required int employerId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create/$employerId");
  }

  Future<Response<dynamic>> unFollow({required int employerId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/delete/$employerId");
  }

  Future<Response<dynamic>> findByEmployerId({required int employerId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("/find/$employerId");
  }

  Future<Response<dynamic>> getEmployerPage({
    required String page,
    int? limit
  }) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("/getPage?page=$page&limit=${limit ?? pageSize}");
  }
}