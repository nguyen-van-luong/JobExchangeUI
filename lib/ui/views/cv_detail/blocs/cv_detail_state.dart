part of 'cv_detail_bloc.dart';

@immutable
sealed class CVDetailState extends Equatable {
  const CVDetailState();

  @override
  List<Object?> get props => [];
}

final class CVInitialState extends CVDetailState {}

class LoadSuccess extends CVDetailState {
  final CV cv;

  LoadSuccess({required this.cv});

  @override
  List<Object?> get props => [cv];
}

class Message extends CVDetailState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}