part of 'student_manage_bloc.dart';

@immutable
sealed class StudentManageState extends Equatable {
  const StudentManageState();

  @override
  List<Object?> get props => [];
}

final class StudentManageInitialState extends StudentManageState {}

class LoadSuccess extends StudentManageState {
  final Student student;
  Message? message;

  LoadSuccess({required this.student, required this.message});

  @override
  List<Object?> get props => [student, message];
}

class Message extends StudentManageState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}