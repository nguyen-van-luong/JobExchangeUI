import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/student_notification.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../dtos/result_count.dart';
import '../../../../../repositories/student_notification_repository.dart';

part 'student_notification_event.dart';
part 'student_notification_state.dart';

class StudentNotificationBloc extends Bloc<StudentNotificationEvent, StudentNotificationState> {
  final StudentNotificationRepository _studentNotificationRepository = StudentNotificationRepository();

  StudentNotificationBloc() : super(StudentNotificationInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<StudentNotificationState> emit) async {
    try {
      Response<dynamic> response =  await _studentNotificationRepository.getPage(isRead: event.isRead,page: 1);
      ResultCount<StudentNotification> studentNotifications = ResultCount.fromJson(response.data, StudentNotification.fromJson, StudentNotification.empty());

      emit(LoadSuccess(result: studentNotifications, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }
}