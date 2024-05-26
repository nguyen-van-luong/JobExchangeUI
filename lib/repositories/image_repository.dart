// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class ImageRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.imagesEndpoint}";

  ImageRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> upload(XFile file) async {
    String fileName = file.name;
    List<int> fileBytes = await file.readAsBytes();
    String fileContents = base64Encode(fileBytes);

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(fileBytes, filename: fileName),
    });
    dio = JwtInterceptor(needToLogin: true).addInterceptors(dio);
    return dio.post('/upload', data: formData);
  }

  Future<Response<dynamic>> deleteByContent(String content) {
    dio = JwtInterceptor(needToLogin: true).addInterceptors(dio);
    return dio.delete('/delete/bycotent', data: content);
  }

}
