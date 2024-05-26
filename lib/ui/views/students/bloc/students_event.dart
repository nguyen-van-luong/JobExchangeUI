part of 'students_bloc.dart';

@immutable
sealed class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends StudentsEvent {
  final String searchContent;
  final int? page;

  const LoadEvent({required this.searchContent,
    required this.page});

  @override
  List<Object?> get props => [searchContent, page];
}