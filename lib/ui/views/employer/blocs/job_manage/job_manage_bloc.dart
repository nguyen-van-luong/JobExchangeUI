import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/job.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../dtos/result_count.dart';
import '../../../../../repositories/job_repository.dart';
import '../../../../router.dart';

part 'job_manage_event.dart';
part 'job_manage_state.dart';

class JobManageBloc extends Bloc<JobManageEvent, JobManageState> {
  final JobRepository _jobRepository = JobRepository();

  JobManageBloc() : super(JobManageInitialState()) {
    on<LoadEvent>(_onLoad);
    on<UpdatePrivate>(_onUpdatePrivate);
    on<DeleteEvent>(_onDelete);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<JobManageState> emit) async {
    try {
      Response<dynamic> response = await _jobRepository.searchByEmployer(
          isPrivate: event.isPrivate,
          searchContent: event.searchContent ?? '',
          page: event.page ?? '1',
      );
      ResultCount<Job> jobs = ResultCount.fromJson(response.data, Job.fromJson, Job.empty());
      List<bool> isCheckeds  = jobs.resultList.map((e) => false).toList();
      emit(LoadSuccess(result: jobs, isCheckeds: isCheckeds, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdatePrivate(
      UpdatePrivate event, Emitter<JobManageState> emit) async {
    try {
      List<Job> jobs = event.data.result.resultList;
      int index = event.index;
      await _jobRepository.updatePrivate(id: jobs[event.index].id, isPrivate: event.isPrivate ?? false);
      jobs[index].isPrivate = event.isPrivate ?? false;

      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }

  Future<void> _onDelete(
      DeleteEvent event, Emitter<JobManageState> emit) async {
    try {
      List<bool> isCheckeds = event.data.isCheckeds;
      List<int> ids = [];
      List<Job> jobs = event.data.result.resultList;
      for(int i = 0; i < isCheckeds.length; i++) {
        if(isCheckeds[i])
          ids.add(jobs[i].id);
      }

      await _jobRepository.deleteList(ids: ids);
      appRouter.go('/job_manage/page=${event.params['page'] ?? '1'}');
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }
}