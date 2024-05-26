import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/dtos/jwt_payload.dart';
import 'package:untitled1/models/application.dart';
import 'package:untitled1/repositories/application_repository.dart';
import 'package:untitled1/repositories/bookmark_repository.dart';
import 'package:untitled1/repositories/cv_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../models/cv.dart';
import '../../../../models/job.dart';
import '../../../../repositories/job_repository.dart';

part 'job_detail_event.dart';
part 'job_detail_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final JobRepository _jobRepository = JobRepository();
  final BookmarkRepository _bookmarkRepository = BookmarkRepository();
  final CVRepository _cvRepository = CVRepository();
  final ApplicationRepository _applicationRepository = ApplicationRepository();

  JobDetailBloc() : super(JobInitialState()) {
    on<LoadEvent>(_onLoad);
    on<BookmarkEvent>(_onBookmark);
    on<ApplicationEvent>(_onApplication);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<JobDetailState> emit) async {
    try {
      Response<dynamic> response = await _jobRepository.getById(id: event.id);
      Job job = Job.fromJson(response.data);
      bool isBookmark = false;

      List<CV> cvs;
      List<Application> applications;
      if(JwtPayload.role != null && JwtPayload.role == 'ROLE_student') {
        response = await _cvRepository.findByStudentId(studentId: '${JwtPayload.userId}');
        cvs = response.data == null ? [] : response.data.map<CV>((e) => CV.fromJson(e as Map<String, dynamic>)).toList();
        response = await _applicationRepository.findByStudentIdAndJobId(studentId: JwtPayload.userId ?? -1, jobId: event.id);
        applications = response.data == null ? [] : response.data.map<Application>((e) => Application.fromJson(e as Map<String, dynamic>)).toList();

        try{
          await _bookmarkRepository.findByJobId(jobId: job.id);
          isBookmark = true;
        } catch (error) {}
      } else {
        cvs = [];
        applications = [];
      }
      List<CV> cvIds = applications.map((application) {
        return application.cv;
      }).toList();

      emit(LoadSuccess(job: job, isBookmark: isBookmark, cvs: cvs, cvApplications: cvIds, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onBookmark(
      BookmarkEvent event, Emitter<JobDetailState> emit) async {
    try {
      if(event.isBookmark) {
        _bookmarkRepository.bookmark(jobId: event.data.job.id);
      } else {
        _bookmarkRepository.unBookmark(jobId: event.data.job.id);
      }
      emit(LoadSuccess(job: event.data.job, isBookmark: event.isBookmark, cvs: event.data.cvs, cvApplications: event.data.cvApplications, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(job: event.data.job, isBookmark: event.data.isBookmark, cvs: event.data.cvs, cvApplications: event.data.cvApplications, message: loadFailure));
    }
  }

  Future<void> _onApplication(
      ApplicationEvent event, Emitter<JobDetailState> emit) async {
    try {
      List<int> cvIds = event.data.cvApplications.map((e) => e.id).toList();
      await _applicationRepository.submit(cvIds: cvIds, jobId: event.data.job.id);
      String message = "Nộp hồ sơ thành công!";
      if(cvIds.isEmpty)
        message = "Đã hũy nộp hồ sơ!";
      Message successMsg =  Message(message: message, notifyType: NotifyType.success);
      emit(LoadSuccess(job: event.data.job, isBookmark: event.data.isBookmark, cvs: event.data.cvs, cvApplications: event.data.cvApplications, message: successMsg));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(job: event.data.job, isBookmark: event.data.isBookmark, cvs: event.data.cvs, cvApplications: event.data.cvApplications, message: loadFailure));
    }
  }
}