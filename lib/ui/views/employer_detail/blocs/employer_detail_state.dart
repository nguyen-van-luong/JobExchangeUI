part of 'employer_detail_bloc.dart';

@immutable
sealed class EmployerDetailState extends Equatable {
  const EmployerDetailState();

  @override
  List<Object?> get props => [];
}

final class EmployerInitialState extends EmployerDetailState {}

class LoadSuccess extends EmployerDetailState {
  final Employer employer;
  final ResultCount<Job>? result;
  bool isFollow;
  Message? message;

  LoadSuccess({required this.employer, required this.isFollow, required this.result, required this.message});

  @override
  List<Object?> get props => [employer, isFollow, result, message];
}

class Message extends EmployerDetailState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}