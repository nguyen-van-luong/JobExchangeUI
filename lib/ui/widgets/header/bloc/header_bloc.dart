import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/employer_notification.dart';
import 'package:untitled1/repositories/employer_notification_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/student_notification.dart';
import '../../../../repositories/student_notification_repository.dart';

part 'header_event.dart';
part 'header_state.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  final EmployerNotificationRepository _employerNotificationRepository = EmployerNotificationRepository();
  final StudentNotificationRepository _studentNotificationRepository = StudentNotificationRepository();

  HeaderBloc() : super(HeaderInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<HeaderState> emit) async {
    try {
      Response<dynamic> response =  await _employerNotificationRepository.getPage(isRead: null, page: 1);
      ResultCount<EmployerNotification> employerNotifications = ResultCount.fromJson(response.data, EmployerNotification.fromJson, EmployerNotification.empty());

      response =  await _studentNotificationRepository.getPage(isRead: null,page: 1);
      ResultCount<StudentNotification> studentNotifications = ResultCount.fromJson(response.data, StudentNotification.fromJson, StudentNotification.empty());
      emit(LoadSuccess(employerNotifications: employerNotifications.resultList, studentNotifications: studentNotifications.resultList));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}