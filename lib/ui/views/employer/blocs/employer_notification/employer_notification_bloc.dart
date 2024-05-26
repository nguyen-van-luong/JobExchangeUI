import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/result_count.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../models/employer_notification.dart';
import '../../../../../repositories/employer_notification_repository.dart';

part 'employer_notification_event.dart';
part 'employer_notification_state.dart';

class EmployerNotificationBloc extends Bloc<EmployerNotificationEvent, EmployerNotificationState> {
  final EmployerNotificationRepository _employerNotificationRepository = EmployerNotificationRepository();

  EmployerNotificationBloc() : super(EmployerNotificationInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<EmployerNotificationState> emit) async {
    try {
      Response<dynamic> response =  await _employerNotificationRepository.getPage(isRead: event.isRead,page: 1);
      ResultCount<EmployerNotification> employerNotifications = ResultCount.fromJson(response.data, EmployerNotification.fromJson, EmployerNotification.empty());

      emit(LoadSuccess(result: employerNotifications, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }
}