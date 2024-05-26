import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/cv.dart';
import 'package:untitled1/models/job.dart';
import 'package:untitled1/repositories/cv_repository.dart';
import 'package:untitled1/repositories/job_repository.dart';
import 'package:untitled1/repositories/student_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';
import '../../../../models/employer.dart';
import '../../../../models/student.dart';
import '../../../../repositories/employer_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EmployerRepository _employerRepository = EmployerRepository();
  final StudentRepository _studentRepository = StudentRepository();
  final JobRepository _jobRepository = JobRepository();
  final CVRepository _cvRepository = CVRepository();

  HomeBloc() : super(HomeInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<HomeState> emit) async {
    try {
      Response<dynamic> response =  await _employerRepository.getSearch(searchContent: "", page: 1, limit: 6);
      ResultCount<Employer> employers = ResultCount.fromJson(response.data, Employer.fromJson, Employer.empty());
      response =  await _studentRepository.getSearch(searchContent: "", page: 1, limit: 6);
      ResultCount<Student> students = ResultCount.fromJson(response.data, Student.fromJson, Student.empty());
      response =  await _jobRepository.propose(page: 1, limit: 6);
      ResultCount<Job> jobs = ResultCount.fromJson(response.data, Job.fromJson, Job.empty());
      response =  await _cvRepository.propose(page: 1, limit: 6);
      ResultCount<CV> cvs = ResultCount.fromJson(response.data, CV.fromJson, CV.empty());
      emit(LoadSuccess(cvs: cvs.resultList, employers: employers.resultList, jobs: jobs.resultList, students: students.resultList));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}