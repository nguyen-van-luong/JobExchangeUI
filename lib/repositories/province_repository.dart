import 'package:dio/dio.dart';

import '../api_config.dart';

class ProvinceRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.provinceEndpoint}";

  ProvinceRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getAll() async {
    return dio.get("");
  }

}