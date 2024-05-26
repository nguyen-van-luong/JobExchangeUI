part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends BookmarkEvent {
  final String page;
  const LoadEvent({required this.page});
}

class OnBookmark extends BookmarkEvent {
  final LoadSuccess data;
  final int index;
  final bool isBookmark;

  const OnBookmark({required this.data, required this.index, required this.isBookmark});

  @override
  List<Object?> get props => [data, index, isBookmark];
}