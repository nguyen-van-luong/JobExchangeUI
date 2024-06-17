import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/repositories/student_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/industry.dart';
import '../../../../models/province.dart';
import '../../../../models/student.dart';
import '../../../../repositories/industry_repository.dart';
import '../../../../repositories/province_repository.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final StudentRepository _studentRepository = StudentRepository();
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();

  StudentsBloc() : super(StudentsInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<StudentsState> emit) async {
    try {
      Response<dynamic> response =  await _studentRepository.getSearch(industry: event.industry, province: event.province, page: event.page ?? 1);

      ResultCount<Student> students = ResultCount.fromJson(response.data, Student.fromJson, Student.empty());
      response = await industryRepository.getAll();
      List<Industry> industries = response.data == null ? [] : response.data.map<Industry>((e) => Industry.fromJson(e as Map<String, dynamic>)).toList();
      Industry industry = Industry.empty();
      industry.name = "Trống";
      industries.insert(0, industry);
      response = await provinceRepository.getAll();
      List<Province> provinces = response.data == null ? [] : response.data.map<Province>((e) => Province.fromJson(e as Map<String, dynamic>)).toList();
      Province province = Province.empty();
      province.name = "Trống";
      provinces.insert(0, province);
      emit(LoadSuccess(result: students, industries: industries, provinces: provinces));
    } catch (error) {
      print(error);
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}