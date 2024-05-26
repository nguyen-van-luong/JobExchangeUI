import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/application_dto.dart';
import 'package:untitled1/models/application.dart';
import 'package:untitled1/repositories/application_repository.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../dtos/result_count.dart';
import '../../../../router.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationRepository _applicationRepository = ApplicationRepository();

  ApplicationBloc() : super(ApplicationInitialState()) {
    on<LoadEvent>(_onLoad);
    on<UpdateStatus>(_onUpdateState);
    on<DeleteEvent>(_onDelete);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<ApplicationState> emit) async {
    try {
      Response<dynamic> response = await _applicationRepository.getSearch(
        page: int.parse(event.page),
        status: event.status,
        title: event.title,
      );

      ResultCount<Application> applications = ResultCount.fromJson(response.data, Application.fromJson, Application.empty());
      List<bool> isCheckeds  = applications.resultList.map((e) => false).toList();
      emit(LoadSuccess(result: applications, isCheckeds: isCheckeds, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdateState(
      UpdateStatus event, Emitter<ApplicationState> emit) async {
    try {
      List<Application> applications = event.data.result.resultList;
      int index = event.index;
      String status = event.status ?? "Chưa xem";
      await _applicationRepository.update(applicationDto: ApplicationDto(jobId: applications[index].job.id, cvId: applications[index].cv.id, status: status));
      applications[index].status = status;

      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }

  Future<void> _onDelete(
      DeleteEvent event, Emitter<ApplicationState> emit) async {
    try {
      List<Application> applicatons = event.data.result.resultList;
      List<ApplicationDto> applicationDtos = [];
      List<bool> isCheckeds = event.data.isCheckeds;
      for(int i = 0; i < isCheckeds.length; i++) {
        if(isCheckeds[i])
          applicationDtos.add(ApplicationDto(jobId: applicatons[i].job.id, cvId: applicatons[i].cv.id, status: applicatons[i].status));
      }
      await _applicationRepository.deleteList(applicationDtos: applicationDtos);
      appRouter.go('/application/title=${event.params['title'] ?? ""}&status=${event.params['status'] ?? ""}&page=${event.params['page'] ?? '1'}');
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }
}