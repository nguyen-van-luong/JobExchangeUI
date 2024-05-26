part of 'logout_bloc.dart';

@immutable
sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends LogoutEvent {
  const LoadEvent();
}