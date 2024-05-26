part of 'industry_manage_bloc.dart';

@immutable
sealed class IndustryManageState extends Equatable {
  const IndustryManageState();

  @override
  List<Object?> get props => [];
}

final class IndustryManageInitialState extends IndustryManageState {}

class LoadSuccess extends IndustryManageState {
  final ResultCount<Industry> result;
  final List<bool> isCheckeds;
  Message? message;

  LoadSuccess({required this.result, required this.isCheckeds, required this.message});

  @override
  List<Object?> get props => [result, isCheckeds, message];
}

class Message extends IndustryManageState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}