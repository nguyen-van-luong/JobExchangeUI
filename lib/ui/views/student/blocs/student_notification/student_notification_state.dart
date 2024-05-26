part of 'student_notification_bloc.dart';

@immutable
sealed class StudentNotificationState extends Equatable {
  const StudentNotificationState();

  @override
  List<Object?> get props => [];
}

final class StudentNotificationInitialState extends StudentNotificationState {}

class LoadSuccess extends StudentNotificationState {
  final ResultCount<StudentNotification> result;
  Message? message;

  LoadSuccess({required this.result, required this.message});

  @override
  List<Object?> get props => [result, message];
}

class Message extends StudentNotificationState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}