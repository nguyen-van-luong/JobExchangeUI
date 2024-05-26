part of 'job_manage_bloc.dart';

@immutable
sealed class JobManageState extends Equatable {
  const JobManageState();

  @override
  List<Object?> get props => [];
}

final class JobManageInitialState extends JobManageState {}

class LoadSuccess extends JobManageState {
  final ResultCount<Job> result;
  final List<bool> isCheckeds;
  Message? message;

  LoadSuccess({required this.result, required this.isCheckeds, required this.message});

  @override
  List<Object?> get props => [result, isCheckeds, message];
}

class Message extends JobManageState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}