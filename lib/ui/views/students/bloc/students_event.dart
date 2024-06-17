part of 'students_bloc.dart';

@immutable
sealed class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends StudentsEvent {
  final String? industry;
  final String? province;
  final int? page;

  const LoadEvent({required this.industry,
    required this.province,
    required this.page});

  @override
  List<Object?> get props => [industry, province, page];
}