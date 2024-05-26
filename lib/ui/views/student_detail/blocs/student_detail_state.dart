part of 'student_detail_bloc.dart';

@immutable
sealed class StudentDetailState extends Equatable {
  const StudentDetailState();

  @override
  List<Object?> get props => [];
}

final class StudentInitialState extends StudentDetailState {}

class LoadSuccess extends StudentDetailState {
  final Student student;
  final ResultCount<CV> result;
  Message? message;

  LoadSuccess({required this.student, required this.result, required this.message});

  @override
  List<Object?> get props => [student, result, message];
}

class Message extends StudentDetailState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}