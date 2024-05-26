import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/repositories/student_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/student.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final StudentRepository _studentRepository = StudentRepository();

  StudentsBloc() : super(StudentsInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<StudentsState> emit) async {
    try {
      Response<dynamic> response =  await _studentRepository.getSearch(searchContent: event.searchContent, page: event.page ?? 1);

      ResultCount<Student> students = ResultCount.fromJson(response.data, Student.fromJson, Student.empty());
      emit(LoadSuccess(result: students));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}