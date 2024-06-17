part of 'cv_detail_bloc.dart';

@immutable
sealed class CVDetailEvent extends Equatable {
  const CVDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CVDetailEvent {
  final String id;

  const LoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteEvent extends CVDetailEvent {
  final int id;

  const DeleteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}