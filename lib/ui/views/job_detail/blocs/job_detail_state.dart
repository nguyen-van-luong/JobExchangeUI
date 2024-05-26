part of 'job_detail_bloc.dart';

@immutable
sealed class JobDetailState extends Equatable {
  const JobDetailState();

  @override
  List<Object?> get props => [];
}

final class JobInitialState extends JobDetailState {}

class LoadSuccess extends JobDetailState {
  final Job job;
  bool isBookmark;
  final List<CV> cvs;
  List<CV> cvApplications;
  Message? message;

  LoadSuccess({required this.job, required this.isBookmark, required this.cvs, required this.cvApplications, required this.message});

  @override
  List<Object?> get props => [job, isBookmark, cvs, cvApplications, message];
}

class Message extends JobDetailState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}