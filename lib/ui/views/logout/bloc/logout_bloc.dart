import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/repositories/fcm_repository.dart';

import '../../../../dtos/notify_type.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final FCMRepository _fcmRepository = FCMRepository();

  LogoutBloc() : super(LogoutInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<LogoutState> emit) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
      if(token != null) {
        await _fcmRepository.delete(token: token);
      }
      emit(LoadSuccess(message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }
}