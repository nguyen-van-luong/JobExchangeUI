import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/notify_type.dart';
import 'package:untitled1/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../repositories/fcm_repository.dart';
import '../../../common/utils/jwt_interceptor.dart';
import '../../../common/utils/message_from_exception.dart';
import '../../../router.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository = AuthRepository();
  final FCMRepository _fcmRepository = FCMRepository();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginSubmitEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {

    if (event.username.isEmpty || event.password.isEmpty) {
      emit(LoginInvalid(usernameInvalid: event.username.isEmpty, passwordInvalid: event.password.isEmpty));
      return;
    }

    try {
      var future = _authRepository.loginUser(
          username: event.username,
          password: event.password);

      await future.then((response) async {
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setString('refreshToken', response.data['token']);
          return JwtInterceptor()
              .refreshAccessToken(prefs, false)
              .then((value) => value != null);
        });
        String? token = await FirebaseMessaging.instance.getToken();
        if(token != null)
          _fcmRepository.create(token: token);
        appRouter.go("/");
      }).catchError((error) {
        print(error);
        String message = getMessageFromException(error);
        emit(LoginFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      print(error);
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoginFailure(message: message, notifyType: NotifyType.error));
    }
  }
}