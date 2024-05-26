part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends HomeEvent {

  const LoadEvent();

  @override
  List<Object?> get props => [];
}