import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/industry.dart';
import 'package:untitled1/repositories/job_repository.dart';

import '../../../../dtos/jwt_payload.dart';
import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/cv.dart';
import '../../../../models/job.dart';
import '../../../../models/province.dart';
import '../../../../repositories/cv_repository.dart';
import '../../../../repositories/industry_repository.dart';
import '../../../../repositories/province_repository.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository _jobRepository = JobRepository();
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();
  final CVRepository _cvRepository = CVRepository();

  JobBloc() : super(JobInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<JobState> emit) async {
    try {
      Response<dynamic> response;
      if(event.propose != null) {
        response = await _jobRepository.proposeForCV(cvId: int.parse(event.propose!), page: event.page ?? 1);
      } else {
        response = await _jobRepository.getSearch(
            page: event.page ?? 1,
            searchContent: event.searchContent,
            industry: event.industry,
            province: event.province,
            workingForm: event.workingForm,
            degree: event.degree,
            salaryTo: event.salaryTo,
            salaryFrom: event.salaryFrom,
            experience: event.experience,
            ageTo: event.ageTo,
            ageFrom: event.ageFrom
        );
      }

      ResultCount<Job> jobs = ResultCount.fromJson(response.data, Job.fromJson, Job.empty());
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

      List<CV> cvs;
      if(JwtPayload.role != null && JwtPayload.role == 'ROLE_student') {
        response = await _cvRepository.findByStudentId(studentId: '${JwtPayload.userId}');
        cvs = response.data == null ? [] : response.data.map<CV>((e) => CV.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        cvs = [];
      }
      emit(LoadSuccess(result: jobs, provinces: provinces, industries: industries, cvs: cvs));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}