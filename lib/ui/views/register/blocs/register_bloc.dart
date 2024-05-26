import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/register_employer.dart';
import 'package:untitled1/dtos/register_student.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../repositories/auth_repository.dart';
import '../../../common/utils/message_from_exception.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository = AuthRepository();

  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterEmployerSubmitEvent>(_onEmployerSubmit);
    on<RegisterStudentSubmitEvent>(_onStudentSubmit);
  }

  Future<void> _onEmployerSubmit(
      RegisterEmployerSubmitEvent event, Emitter<RegisterState> emit) async {

    RegisterEmployer registerEmployer = event.registerEmployer;
    if (registerEmployer.username.isEmpty || registerEmployer.password.isEmpty
        || registerEmployer.name.isEmpty || registerEmployer.email.isEmpty
        || event.repassword != registerEmployer.password) {
      emit(RegisterEmployerInvalid(registerEmployer.username.isEmpty,
          registerEmployer.password.isEmpty, registerEmployer.name.isEmpty,
          registerEmployer.email.isEmpty, true));
      return;
    }

    try {
      var future = _authRepository.registerEmployer(registerEmployer);

      await future.then((response) {
        emit(RegisterSuccess());
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(RegisterFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(RegisterFailure(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onStudentSubmit(
      RegisterStudentSubmitEvent event, Emitter<RegisterState> emit) async {

    RegisterStudent registerStudent = event.registerStudent;
    if (registerStudent.username.isEmpty || registerStudent.password.isEmpty
        || registerStudent.fullname.isEmpty || registerStudent.email.isEmpty
        || registerStudent.password != event.repassword) {
      emit(RegisterEmployerInvalid(registerStudent.username.isEmpty,
          registerStudent.password.isEmpty, registerStudent.fullname.isEmpty,
          registerStudent.email.isEmpty, true));
      return;
    }

    try {
      var future = _authRepository.registerStudent(registerStudent);

      await future.then((response) {
        emit(RegisterSuccess());
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(RegisterFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(RegisterFailure(message: message, notifyType: NotifyType.error));
    }
  }
}