part of 'logout_bloc.dart';

@immutable
sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object?> get props => [];
}

final class LogoutInitialState extends LogoutState {}

class LoadSuccess extends LogoutState {
  Message? message;

  LoadSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class Message extends LogoutState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}