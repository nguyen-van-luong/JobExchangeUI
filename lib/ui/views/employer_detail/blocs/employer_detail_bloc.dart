import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/employer.dart';
import 'package:untitled1/models/job.dart';
import 'package:untitled1/repositories/employer_repository.dart';
import 'package:untitled1/repositories/follow_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../repositories/job_repository.dart';

part 'employer_detail_event.dart';
part 'employer_detail_state.dart';

class EmployerDetailBloc extends Bloc<EmployerDetailEvent, EmployerDetailState> {
  final EmployerRepository _employerRepository = EmployerRepository();
  final FollowRepository _followRepository = FollowRepository();
  final JobRepository _jobRepository = JobRepository();

  EmployerDetailBloc() : super(EmployerInitialState()) {
    on<LoadEvent>(_onLoad);
    on<FollowEvent>(_onFollow);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<EmployerDetailState> emit) async {
    try {
      Response<dynamic> response = await _employerRepository.get(event.id);
      Employer employer = Employer.fromJson(response.data);
      ResultCount<Job>? result = null;
      if(event.page != null) {
        response = await _jobRepository.getByEmployerId(
            page: event.page ?? '1',
            employerId: event.id
        );
        result = ResultCount.fromJson(response.data, Job.fromJson, Job.empty());
      }

      ResultCount<Job> jobs = ResultCount.fromJson(response.data, Job.fromJson, Job.empty());
      bool isFollow = false;
      try{
        await _followRepository.findByEmployerId(employerId: employer.id);
        isFollow = true;
      } catch (error) {}
      emit(LoadSuccess(employer: employer, isFollow: isFollow, result: result, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onFollow(
      FollowEvent event, Emitter<EmployerDetailState> emit) async {
    try {
      if(event.isFollow) {
        _followRepository.follow(employerId: event.data.employer.id);
      } else {
        _followRepository.unFollow(employerId: event.data.employer.id);
      }
      emit(LoadSuccess(employer: event.data.employer, isFollow: event.isFollow, result: event.data.result, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(employer: event.data.employer, isFollow: event.isFollow, result: event.data.result, message: loadFailure));
    }
  }
}