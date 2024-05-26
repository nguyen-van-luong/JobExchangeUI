import 'package:dio/dio.dart';
import 'package:untitled1/models/employer.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class EmployerRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.employerEndpoint}";

  EmployerRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> update(Employer employer) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: employer.toJson(),
    );
  }

  Future<Response<dynamic>> get(String employerId) async {
    return dio.get("/$employerId");
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