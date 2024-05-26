part of 'employer_manage_bloc.dart';

@immutable
sealed class EmployerManageState extends Equatable {
  const EmployerManageState();

  @override
  List<Object?> get props => [];
}

final class EmployerManageInitialState extends EmployerManageState {}

class LoadSuccess extends EmployerManageState {
  final Employer employer;
  Message? message;

  LoadSuccess({required this.employer, required this.message});

  @override
  List<Object?> get props => [employer, message];
}

class Message extends EmployerManageState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}