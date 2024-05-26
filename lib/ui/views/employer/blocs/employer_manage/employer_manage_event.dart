part of 'employer_manage_bloc.dart';

@immutable
sealed class EmployerManageEvent extends Equatable {
  const EmployerManageEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends EmployerManageEvent {
  const LoadEvent();
}

class UpdateEvent extends EmployerManageEvent {
  final Employer employer;

  const UpdateEvent({required this.employer});

  @override
  List<Object?> get props => [employer];
}