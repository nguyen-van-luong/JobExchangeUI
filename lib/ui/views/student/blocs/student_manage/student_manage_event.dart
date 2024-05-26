part of 'student_manage_bloc.dart';

@immutable
sealed class StudentManageEvent extends Equatable {
  const StudentManageEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends StudentManageEvent {
  const LoadEvent();
}

class UpdateEvent extends StudentManageEvent {
  final Student student;

  const UpdateEvent({required this.student});

  @override
  List<Object?> get props => [student];
}