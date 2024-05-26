import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/cv.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/student.dart';
import '../../../../repositories/cv_repository.dart';
import '../../../../repositories/student_repository.dart';

part 'student_detail_event.dart';
part 'student_detail_state.dart';

class StudentDetailBloc extends Bloc<StudentDetailEvent, StudentDetailState> {
  final StudentRepository _studentRepository = StudentRepository();
  final CVRepository _cvRepository = CVRepository();

  StudentDetailBloc() : super(StudentInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<StudentDetailState> emit) async {
    try {
      Response<dynamic> response = await _studentRepository.get(event.id);
      Student student = Student.fromJson(response.data);

      response = await _cvRepository.getByStudentId(
          page: event.page,
          studentId: event.id
      );

      ResultCount<CV>? result = ResultCount.fromJson(response.data, CV.fromJson, CV.empty());

      emit(LoadSuccess(student: student, result: result, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }
}