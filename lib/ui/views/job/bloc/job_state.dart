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

  LoadSuccess({required this.result, required this.industries, required this.provinces});

  @override
  List<Object?> get props => [result, industries, provinces];
}

class LoadFailure extends JobState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}