import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/job_dto.dart';
import 'package:untitled1/models/province.dart';
import 'package:untitled1/repositories/industry_repository.dart';
import 'package:untitled1/repositories/province_repository.dart';
import 'package:untitled1/repositories/skill_repository.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/job.dart';
import '../../../../../models/skill.dart';
import '../../../../../repositories/job_repository.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../router.dart';

part 'cu_job_event.dart';
part 'cu_job_state.dart';

class CUJobBloc extends Bloc<CUJobEvent, CUJobState> {
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();
  SkillRepository skillRepository = SkillRepository();
  JobRepository jobRepository = JobRepository();

  CUJobBloc() : super(CUJobInitialState()) {
    on<LoadEvent>(_onLoad);
    on<SaveEvent>(_onSave);
    on<UpdateEvent>(_onUpdate);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<CUJobState> emit) async {
    Job? job = null;
    Response<dynamic> response;
    if(event.id != null) {
      response = await jobRepository.getById(id: '${event.id}');
      job = Job.fromJson(response.data);
    }
    response = await industryRepository.getAll();

    List<Industry> industries = response.data == null ? [] : response.data.map<Industry>((e) => Industry.fromJson(e as Map<String, dynamic>)).toList();

    response = await provinceRepository.getAll();
    List<Province> provinces = response.data == null ? [] : response.data.map<Province>((e) => Province.fromJson(e as Map<String, dynamic>)).toList();
    response = await skillRepository.getAll();
    List<Skill> skills = response.data == null ? [] : response.data.map<Skill>((e) => Skill.fromJson(e as Map<String, dynamic>)).toList();

    emit(CuJobStateData(job: job, industries: industries, provinces: provinces, skills: skills));
  }

  Future<void> _onSave(
      SaveEvent event, Emitter<CUJobState> emit) async {
    try {
      var future = jobRepository.save(event.job);

      await future.then((response) {
        Job job = Job.fromJson(response.data);
        emit(SaveSuccess(jobId: job.id));
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(PostFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(PostFailure(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdate(
      UpdateEvent event, Emitter<CUJobState> emit) async {
    try {
      var future = jobRepository.update(id: event.id, jobDto: event.job);

      await future.then((response) {
        emit(SaveSuccess(jobId: event.id));
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(PostFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(PostFailure(message: message, notifyType: NotifyType.error));
    }
  }
}