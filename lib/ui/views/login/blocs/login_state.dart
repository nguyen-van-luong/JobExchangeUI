part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitialState extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  final NotifyType notifyType;

  LoginFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}

class LoginInvalid extends LoginState {
  final bool usernameInvalid;
  final bool passwordInvalid;

  LoginInvalid({required this.usernameInvalid, required this.passwordInvalid});

  @override
  List<Object?> get props => [usernameInvalid, passwordInvalid];
}

class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}