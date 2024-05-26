part of 'student_detail_bloc.dart';

@immutable
sealed class StudentDetailEvent extends Equatable {
  const StudentDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends StudentDetailEvent {
  final String id;
  final String page;

  const LoadEvent({required this.id, required this.page});

  @override
  List<Object?> get props => [id, page];
}