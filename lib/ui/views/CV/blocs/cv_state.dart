part of 'cv_bloc.dart';

@immutable
sealed class CVState extends Equatable {
  const CVState();

  @override
  List<Object?> get props => [];
}

final class JobInitialState extends CVState {}

class LoadSuccess extends CVState {
  final ResultCount<CV> result;
  final List<Industry> industries;
  final List<Province> provinces;

  LoadSuccess({required this.result, required this.industries, required this.provinces});

  @override
  List<Object?> get props => [result, industries, provinces];
}

class LoadFailure extends CVState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}