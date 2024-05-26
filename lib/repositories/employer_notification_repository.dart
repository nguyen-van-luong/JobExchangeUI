
import 'package:dio/dio.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class EmployerNotificationRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.employerNotificationEndpoint}";

  EmployerNotificationRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getPage({
    required bool? isRead,
    required int page,
    int? limit}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    String param = "";
    if(isRead != null) {
      param = "isRead=$isRead&";
    }
    param += 'page';

    return dio.get(
        '/getPage?$param=$page&limit=${limit ?? 20}');
  }

  Future<Response<dynamic>> update({
    required int id}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put('/update/$id');
  }

}