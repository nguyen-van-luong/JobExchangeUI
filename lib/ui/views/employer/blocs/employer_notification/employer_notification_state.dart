part of 'employer_notification_bloc.dart';

@immutable
sealed class EmployerNotificationState extends Equatable {
  const EmployerNotificationState();

  @override
  List<Object?> get props => [];
}

final class EmployerNotificationInitialState extends EmployerNotificationState {}

class LoadSuccess extends EmployerNotificationState {
  final ResultCount<EmployerNotification> result;
  Message? message;

  LoadSuccess({required this.result, required this.message});

  @override
  List<Object?> get props => [result, message];
}

class Message extends EmployerNotificationState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}