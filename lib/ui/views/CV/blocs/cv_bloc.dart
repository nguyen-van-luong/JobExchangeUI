import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/repositories/job_repository.dart';

import '../../../../dtos/jwt_payload.dart';
import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/cv.dart';
import '../../../../models/industry.dart';
import '../../../../models/job.dart';
import '../../../../models/province.dart';
import '../../../../repositories/cv_repository.dart';
import '../../../../repositories/industry_repository.dart';
import '../../../../repositories/province_repository.dart';

part 'cv_event.dart';
part 'cv_state.dart';

class CVBloc extends Bloc<CVEvent, CVState> {
  final CVRepository _cvRepository = CVRepository();
  final JobRepository _jobRepository = JobRepository();
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();

  CVBloc() : super(JobInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<CVState> emit) async {
    try {
      Response<dynamic> response;
      if(event.propose != null) {
        response = await _cvRepository.proposeForJob(jobId: int.parse(event.propose!), page: event.page ?? 1);
      } else {
        response = await _cvRepository.getSearch(
          page: event.page ?? 1,
          searchContent: event.searchContent,
          industry: event.industry,
          province: event.province,
          workingForm: event.workingForm,
          salaryTo: event.salaryTo,
          salaryFrom: event.salaryFrom,
          experience: event.experience,
        );
      }

      ResultCount<CV> cvs = ResultCount.fromJson(response.data, CV.fromJson, CV.empty());
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

      List<Job> jobs;
      if(JwtPayload.role != null && JwtPayload.role == 'ROLE_employer') {
        response = await _jobRepository.findByEmployerId(employerId: '${JwtPayload.userId}');
        jobs = response.data == null ? [] : response.data.map<Job>((e) => Job.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        jobs = [];
      }
      emit(LoadSuccess(result: cvs, provinces: provinces, industries: industries, jobs: jobs));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}