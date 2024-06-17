part of 'job_detail_bloc.dart';

@immutable
sealed class JobDetailEvent extends Equatable {
  const JobDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends JobDetailEvent {
  final String id;

  const LoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class BookmarkEvent extends JobDetailEvent {
  final LoadSuccess data;
  final bool isBookmark;

  const BookmarkEvent({required this.data, required this.isBookmark});

  @override
  List<Object?> get props => [data, isBookmark];
}

class ApplicationEvent extends JobDetailEvent {
  final LoadSuccess data;

  const ApplicationEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class DeleteEvent extends JobDetailEvent {
  final int id;

  const DeleteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}