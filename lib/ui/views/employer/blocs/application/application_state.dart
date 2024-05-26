part of 'application_bloc.dart';

@immutable
sealed class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object?> get props => [];
}

final class ApplicationInitialState extends ApplicationState {}

class LoadSuccess extends ApplicationState {
  final ResultCount<Application> result;
  final List<bool> isCheckeds;
  Message? message;

  LoadSuccess({required this.result, required this.isCheckeds, required this.message});

  @override
  List<Object?> get props => [result, isCheckeds, message];
}

class Message extends ApplicationState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}