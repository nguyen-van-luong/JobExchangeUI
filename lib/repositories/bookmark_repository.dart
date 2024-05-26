
import 'package:dio/dio.dart';

import '../api_config.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class BookmarkRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.bookmarkEndpoint}";

  BookmarkRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
  Future<Response<dynamic>> bookmark({required int jobId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create/$jobId");
  }

  Future<Response<dynamic>> unBookmark({required int jobId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/delete/$jobId");
  }

  Future<Response<dynamic>> findByJobId({required int jobId}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("/find/$jobId");
  }

  Future<Response<dynamic>> getJobPage({
    required String page,
    int? limit
  }) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.get("/getPage?page=$page&limit=${limit ?? pageSize}");
  }
}