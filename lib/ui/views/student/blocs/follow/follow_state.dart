part of 'follow_bloc.dart';

@immutable
sealed class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object?> get props => [];
}

final class FollowInitialState extends FollowState {}

class LoadSuccess extends FollowState {
  final ResultCount<Follow>? result;
  List<bool> follows;
  Message? message;

  LoadSuccess({required this.result, required this.follows, required this.message});

  @override
  List<Object?> get props => [result, follows, message];
}

class Message extends FollowState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}