part of 'follow_bloc.dart';

@immutable
sealed class FollowEvent extends Equatable {
  const FollowEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends FollowEvent {
  final String page;
  const LoadEvent({required this.page});
}

class OnFollow extends FollowEvent {
  final LoadSuccess data;
  final int index;
  final bool isFollow;

  const OnFollow({required this.data, required this.index, required this.isFollow});

  @override
  List<Object?> get props => [data, index, isFollow];
}