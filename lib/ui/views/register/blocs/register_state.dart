part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterInitialState extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;
  final NotifyType notifyType;

  RegisterFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}

class RegisterEmployerInvalid extends RegisterState {
  final bool usernameInvalid;
  final bool passwordInvalid;
  final bool nameInvalid;
  final bool emailInvalid;
  final bool repasswordInvalid;

  RegisterEmployerInvalid(this.usernameInvalid, this.passwordInvalid,
      this.nameInvalid, this.emailInvalid, this.repasswordInvalid);

  @override
  List<Object?> get props => [usernameInvalid, passwordInvalid, nameInvalid, emailInvalid, repasswordInvalid];
}

class RegisterStudentInvalid extends RegisterState {
  final bool usernameInvalid;
  final bool passwordInvalid;
  final bool fullnameInvalid;
  final bool emailInvalid;
  final bool repasswordInvalid;

  RegisterStudentInvalid(this.usernameInvalid, this.passwordInvalid,
      this.fullnameInvalid, this.emailInvalid, this.repasswordInvalid);

  @override
  List<Object?> get props => [usernameInvalid, passwordInvalid, fullnameInvalid, emailInvalid, repasswordInvalid];
}

class RegisterSuccess extends RegisterState {}