part of 'job_bloc.dart';

@immutable
sealed class JobState extends Equatable {
  const JobState();

  @override
  List<Object?> get props => [];
}

final class JobInitialState extends JobState {}

class LoadSuccess extends JobState {
  final ResultCount<Job> result;
  final List<Industry> industries;
  final List<Province> provinces;
  final List<CV> cvs;

  LoadSuccess({required this.result, required this.industries, required this.provinces, required this.cvs});

  @override
  List<Object?> get props => [result, industries, provinces, cvs];
}

class LoadFailure extends JobState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}