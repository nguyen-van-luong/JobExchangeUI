import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:untitled1/dtos/job_dto.dart';
import 'package:untitled1/dtos/jwt_payload.dart';

import '../api_config.dart';
import '../ui/common/app_constants.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class JobRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.jobEndpoint}";

  JobRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> save(JobDto job) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.post('/create', data: job.toJson());
  }

  Future<Response<dynamic>> getById({required String id}) async {

    return dio.get('/$id');
  }

  Future<Response<dynamic>> getSearch({
        required String searchContent,
        required String? industry,
        required String? province,
        required String? experience,
        required int? salaryFrom,
        required int? salaryTo,
        required int? ageFrom,
        required int? ageTo,
        required String? degree,
        required String? workingForm,
        required int page,
        int? limit}) async {
    String param = "searchContent=" + searchContent ?? "";
    if(industry != null && industry.isNotEmpty)
      param += "&industry=$industry";
    if(province != null && province.isNotEmpty)
      param += "&province=$province";
    if(ageFrom != null)
      param += "&ageFrom=$ageFrom";
    if(ageTo != null)
      param += "&ageTo=$ageTo";
    if(salaryFrom != null)
      param += "&salaryFrom=$salaryFrom";
    if(workingForm != null && workingForm.isNotEmpty)
      param += "&workingForm=$workingForm";
    if(experience != null && experience.isNotEmpty)
      param += "&experience=$experience";
    if(degree != null && degree.isNotEmpty)
      param += "&degree=$degree";
    if(salaryTo != null)
      param += "&salaryTo=$salaryTo";

    return dio.get(
          '/search?$param&page=$page&limit=${limit ?? pageSize}');
  }

  Future<Response<dynamic>> getByEmployerId({
    required String employerId,
    required String page,
    int? limit
  }) async {
    dio = JwtInterceptor().addInterceptors(dio);
    String param = "employerId=$employerId";
    return dio.get('/getByEmployer?$param&page=$page&limit=${limit ?? pageSize}');
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
    return dio.get('/searchByEmployer?$param&page=$page&limit=${limit ?? pageSize}');
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

  Future<Response<dynamic>> proposeForCV({
    required int cvId,
    required int page,
    int? limit}) async {
    String param = '';
    param += 'page=$page&limit=${limit ?? pageSize}';
    return dio.get(
        '/propose/$cvId?$param');
  }

  Future<Response<dynamic>> findByEmployerId({required String employerId}) async {

    return dio.get('/find/$employerId');
  }

  Future<Response<dynamic>> deleteList({required List<int> ids}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.delete("/deletes", data: jsonEncode(ids));
  }

  Future<Response<dynamic>> delete({required int id}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.delete("/delete", data: jsonEncode(id));
  }

  Future<Response<dynamic>> updatePrivate({required int id, required bool isPrivate}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/update/$id/$isPrivate");
  }

  Future<Response<dynamic>> update({required int id,required JobDto jobDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);

    return dio.put("/update/$id", data: jobDto.toJson());
  }

}