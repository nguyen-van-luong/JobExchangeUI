part of 'cv_manage_bloc.dart';

@immutable
sealed class CVManageState extends Equatable {
  const CVManageState();

  @override
  List<Object?> get props => [];
}

final class CVManageInitialState extends CVManageState {}

class LoadSuccess extends CVManageState {
  final ResultCount<CV> result;
  final List<bool> isCheckeds;
  Message? message;

  LoadSuccess({required this.result, required this.isCheckeds, required this.message});

  @override
  List<Object?> get props => [result, isCheckeds, message];
}

class Message extends CVManageState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}