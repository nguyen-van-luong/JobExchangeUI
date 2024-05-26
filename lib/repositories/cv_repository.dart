import 'dart:convert';

import 'package:dio/dio.dart';

import '../api_config.dart';
import '../dtos/cv_dto.dart';
import '../dtos/jwt_payload.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class CVRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.cvEndpoint}";

  CVRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> getById({required String id}) async {

    return dio.get('/$id');
  }

  Future<Response<dynamic>> save(CVDto cv) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post('/create', data: cv.toJson());
  }

  Future<Response<dynamic>> getSearch({
    required String searchContent,
    required String? industry,
    required String? province,
    required String? experience,
    required int? salaryFrom,
    required int? salaryTo,
    required String? workingForm,
    required int page,
    int? limit}) async {
    String param = "searchContent=" + searchContent ?? "";
    if(industry != null && industry.isNotEmpty)
      param += "&industry=$industry";
    if(province != null && province.isNotEmpty)
      param += "&province=$province";
    if(salaryFrom != null)
      param += "&salaryFrom=$salaryFrom";
    if(workingForm != null && workingForm.isNotEmpty)
      param += "&workingForm=$workingForm";
    if(experience != null && experience.isNotEmpty)
      param += "&experience=$experience";
    if(salaryTo != null)
      param += "&salaryTo=$salaryTo";

    return dio.get(
        '/search?$param&page=$page&limit=${limit ?? pageSize}');
  }

  Future<Response<dynamic>> findByStudentId({required String studentId}) async {

    return dio.get('/find/$studentId');
  }

  Future<Response<dynamic>> getByStudentId({
    required String studentId,
    required String page,
    int? limit
  }) async {
    String param = "studentId=$studentId";
    return dio.get('/getByStudent?$param&page=$page&limit=${limit ?? pageSize}');
  }

  Future<Response<dynamic>> deleteList({required List<int> ids}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.delete("/delete", data: jsonEncode(ids));
  }

  Future<Response<dynamic>> updatePrivate({required int id, required bool isPrivate}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/update/$id/$isPrivate");
  }

  Future<Response<dynamic>> update({required int id,required CVDto cvDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/update/$id", data: cvDto.toJson());
  }

  Future<Response<dynamic>> propose({
    required int page,
    int? limit}) async {
    String param = '';
    if(JwtPayload.userId != null) {
      param += 'studentId=${JwtPayload.userId}&';
    }
    param += 'page=$page&limit=${limit ?? pageSize}';
    return dio.get(
        '/propose?$param');
  }

  Future<Response<dynamic>> searchByEmployer({
    required String searchContent,
    required bool? isPrivate,
    required String page,
    int? limit
  }) async {
    dio = JwtInterceptor().addInterceptors(dio);
    String param = "searchContent=" + searchContent ?? "";
    if(isPrivate != null)
      param += "&isPrivate=$isPrivate";
    return dio.get('/searchByStudent?$param&page=$page&limit=${limit ?? pageSize}');
  }
}