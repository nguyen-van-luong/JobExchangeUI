part of 'employer_detail_bloc.dart';

@immutable
sealed class EmployerDetailEvent extends Equatable {
  const EmployerDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends EmployerDetailEvent {
  final String id;
  final String? page;

  const LoadEvent({required this.id, required this.page});

  @override
  List<Object?> get props => [id, page];
}

class FollowEvent extends EmployerDetailEvent {
  final LoadSuccess data;
  final bool isFollow;

  const FollowEvent({required this.data, required this.isFollow});

  @override
  List<Object?> get props => [data, isFollow];
}