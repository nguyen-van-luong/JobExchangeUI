part of 'job_bloc.dart';

@immutable
sealed class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends JobEvent {
  final String searchContent;
  final String? industry;
  final String? province;
  final String? experience;
  final int? salaryFrom;
  final int? salaryTo;
  final int? ageFrom;
  final int? ageTo;
  final String? degree;
  final String? workingForm;
  final String? propose;
  final int? page;

  const LoadEvent({required this.searchContent,
    required this.industry,
    required this.province,
    required this.experience,
    required this.workingForm,
    required this.ageTo,
    required this.ageFrom,
    required this.salaryTo,
    required this.salaryFrom,
    required this.degree,
    required this.propose,
    required this.page});

  @override
  List<Object?> get props => [searchContent, industry, province, experience, propose,
    workingForm, ageTo, ageFrom, salaryTo, salaryFrom, degree, page];
}