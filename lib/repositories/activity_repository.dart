import 'package:dio/dio.dart';
import 'package:untitled1/dtos/activity_dto.dart';
import 'package:untitled1/models/activity.dart';

import '../api_config.dart';
import '../ui/common/utils/jwt_interceptor.dart';

class ActivityRepository {
  late Dio dio;
  final String baseUrl = "${ApiConfig.baseUrl}/${ApiConfig.activityEndpoint}";

  ActivityRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<dynamic>> create({required ActivityDto activityDto}) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.post("/create", data: activityDto.toJson());
  }

  Future<Response<dynamic>> update(Activity activity) async {
    dio = JwtInterceptor().addInterceptors(dio);
    return dio.put(
      "/update",
      data: activity.toJson(),
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