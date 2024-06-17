part of 'cv_bloc.dart';

@immutable
sealed class CVEvent extends Equatable {
  const CVEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CVEvent {
  final String searchContent;
  final String? industry;
  final String? province;
  final String? experience;
  final int? salaryFrom;
  final int? salaryTo;
  final String? workingForm;
  final String? propose;
  final int? page;

  const LoadEvent({required this.searchContent,
    required this.industry,
    required this.province,
    required this.experience,
    required this.workingForm,
    required this.salaryTo,
    required this.salaryFrom,
    required this.propose,
    required this.page});

  @override
  List<Object?> get props => [searchContent, industry, province, experience, workingForm, salaryTo, salaryFrom, propose, page];
}