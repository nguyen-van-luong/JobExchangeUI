part of 'employer_notification_bloc.dart';

@immutable
sealed class EmployerNotificationEvent extends Equatable {
  const EmployerNotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends EmployerNotificationEvent {
  final String page;
  final bool? isRead;

  const LoadEvent({required this.isRead, required this.page});

  @override
  List<Object?> get props => [isRead, page];
}