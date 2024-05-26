part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}