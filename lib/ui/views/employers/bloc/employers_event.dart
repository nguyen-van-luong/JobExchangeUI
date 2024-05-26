part of 'employers_bloc.dart';

@immutable
sealed class EmployersEvent extends Equatable {
  const EmployersEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends EmployersEvent {
  final String searchContent;
  final int? page;

  const LoadEvent({required this.searchContent,
    required this.page});

  @override
  List<Object?> get props => [searchContent, page];
}