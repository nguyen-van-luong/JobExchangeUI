import 'package:dio/dio.dart';
import 'package:untitled1/models/student.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class StudentRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.studentEndpoint}";

  StudentRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> update(Student student) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: student.toJson(),
    );
  }

  Future<Response<dynamic>> get(String studentId) async {
    return dio.get("/$studentId");
  }

  Future<Response<dynamic>> getSearch({
    required String? searchContent,
    required int page,
    int? limit}) async {
    String param = "";
    if(searchContent != null && searchContent.isNotEmpty)
      param += "searchContent=$searchContent&";

    return dio.get(
        '/search?${param}page=$page&limit=${limit ?? 20}');
  }

}