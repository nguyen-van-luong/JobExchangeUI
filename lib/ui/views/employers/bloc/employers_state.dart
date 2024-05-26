part of 'employers_bloc.dart';

@immutable
sealed class EmployersState extends Equatable {
  const EmployersState();

  @override
  List<Object?> get props => [];
}

final class EmployersInitialState extends EmployersState {}

class LoadSuccess extends EmployersState {
  final ResultCount<Employer> result;

  LoadSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class LoadFailure extends EmployersState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}