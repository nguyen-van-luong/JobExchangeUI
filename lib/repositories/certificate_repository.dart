import 'package:dio/dio.dart';
import 'package:untitled1/dtos/certificate_dto.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class CertificateRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.certificateEndpoint}";

  CertificateRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required CertificateDto certificateDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: certificateDto.toJson());
  }

  Future<Response<dynamic>> update(CertificateDto certificateDto) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: certificateDto.toJson(),
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