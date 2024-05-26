part of 'students_bloc.dart';

@immutable
sealed class StudentsState extends Equatable {
  const StudentsState();

  @override
  List<Object?> get props => [];
}

final class StudentsInitialState extends StudentsState {}

class LoadSuccess extends StudentsState {
  final ResultCount<Student> result;

  LoadSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class LoadFailure extends StudentsState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}