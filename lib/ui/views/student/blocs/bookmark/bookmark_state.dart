part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object?> get props => [];
}

final class BookmarkInitialState extends BookmarkState {}

class LoadSuccess extends BookmarkState {
  final ResultCount<Bookmark>? result;
  List<bool> bookmarks;
  Message? message;

  LoadSuccess({required this.result, required this.bookmarks, required this.message});

  @override
  List<Object?> get props => [result, bookmarks, message];
}

class Message extends BookmarkState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}