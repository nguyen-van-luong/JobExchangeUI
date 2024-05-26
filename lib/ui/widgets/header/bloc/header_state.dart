part of 'header_bloc.dart';

@immutable
sealed class HeaderState extends Equatable {
  const HeaderState();

  @override
  List<Object?> get props => [];
}

final class HeaderInitialState extends HeaderState {}

class LoadSuccess extends HeaderState {
  final List<EmployerNotification> employerNotifications;
  final List<StudentNotification> studentNotifications;

  LoadSuccess({required this.employerNotifications, required this.studentNotifications});

  @override
  List<Object?> get props => [employerNotifications, studentNotifications];
}

class LoadFailure extends HeaderState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}