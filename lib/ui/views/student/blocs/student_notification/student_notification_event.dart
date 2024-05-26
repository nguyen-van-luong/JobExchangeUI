part of 'student_notification_bloc.dart';

@immutable
sealed class StudentNotificationEvent extends Equatable {
  const StudentNotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends StudentNotificationEvent {
  final String page;
  final bool? isRead;

  const LoadEvent({required this.isRead, required this.page});

  @override
  List<Object?> get props => [isRead, page];
}