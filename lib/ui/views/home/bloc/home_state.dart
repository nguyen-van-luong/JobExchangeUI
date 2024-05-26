part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitialState extends HomeState {}

class LoadSuccess extends HomeState {
  final List<Employer> employers;
  final List<Student> students;
  final List<Job> jobs;
  final List<CV> cvs;

  LoadSuccess({required this.employers, required this.students, required this.jobs, required this.cvs});

  @override
  List<Object?> get props => [employers, students, jobs, cvs];
}

class LoadFailure extends HomeState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}