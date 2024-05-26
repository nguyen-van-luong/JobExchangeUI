import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../models/employer.dart';
import '../../../../../repositories/employer_repository.dart';

part 'employer_manage_event.dart';
part 'employer_manage_state.dart';

class EmployerManageBloc extends Bloc<EmployerManageEvent, EmployerManageState> {
  final EmployerRepository _employerRepository = EmployerRepository();

  EmployerManageBloc() : super(EmployerManageInitialState()) {
    on<LoadEvent>(_onLoad);
    on<UpdateEvent>(_onUpdate);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<EmployerManageState> emit) async {
    try {
      Response<dynamic> response = await _employerRepository.get(JwtPayload.userId!.toString());
      Employer employer = Employer.fromJson(response.data);
      List<bool> bookmarks = [];
      emit(LoadSuccess(employer: employer, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdate(
      UpdateEvent event, Emitter<EmployerManageState> emit) async {
    try {
      await _employerRepository.update(event.employer);
      String message = "Cập nhật thành công!";
      Message successMsg =  Message(message: message, notifyType: NotifyType.success);

      emit(LoadSuccess(employer: event.employer, message: successMsg));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(employer: event.employer, message: loadFailure));
    }
  }
}