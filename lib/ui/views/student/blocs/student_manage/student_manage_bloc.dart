import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/jwt_payload.dart';
import 'package:untitled1/models/student.dart';
import 'package:untitled1/repositories/student_repository.dart';

import '../../../../../dtos/notify_type.dart';

part 'student_manage_event.dart';
part 'student_manage_state.dart';

class StudentManageBloc extends Bloc<StudentManageEvent, StudentManageState> {
  final StudentRepository _studentRepository = StudentRepository();

  StudentManageBloc() : super(StudentManageInitialState()) {
    on<LoadEvent>(_onLoad);
    on<UpdateEvent>(_onUpdate);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<StudentManageState> emit) async {
    try {
      Response<dynamic> response = await _studentRepository.get(JwtPayload.userId!.toString());
      Student student = Student.fromJson(response.data);
      List<bool> bookmarks = [];
      emit(LoadSuccess(student: student, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdate(
      UpdateEvent event, Emitter<StudentManageState> emit) async {
    try {
      await _studentRepository.update(event.student);
      String message = "Cập nhật thành công!";
      Message successMsg =  Message(message: message, notifyType: NotifyType.success);

      emit(LoadSuccess(student: event.student, message: successMsg));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(student: event.student, message: loadFailure));
    }
  }
}