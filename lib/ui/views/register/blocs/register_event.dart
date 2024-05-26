part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEmployerSubmitEvent extends RegisterEvent {
  final RegisterEmployer registerEmployer;
  final String repassword;

  const RegisterEmployerSubmitEvent({required this.registerEmployer, required this.repassword});
}

class RegisterStudentSubmitEvent extends RegisterEvent {
  final RegisterStudent registerStudent;
  final String repassword;

  const RegisterStudentSubmitEvent({required this.registerStudent, required this.repassword});
}