part of 'header_bloc.dart';

@immutable
sealed class HeaderEvent extends Equatable {
  const HeaderEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends HeaderEvent {
  final String searchContent;
  final int? page;

  const LoadEvent({required this.searchContent,
    required this.page});

  @override
  List<Object?> get props => [searchContent, page];
}