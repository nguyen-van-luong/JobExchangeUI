part of 'cu_cv_bloc.dart';

@immutable
sealed class CUCVState extends Equatable {
  const CUCVState();

  @override
  List<Object?> get props => [];
}

final class CUCVInitialState extends CUCVState {}

class Message extends CUCVState {
  final String message;
  final NotifyType notifyType;

  Message({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}

class CuCVStateData extends CUCVState {
  final CV? cv;
  final List<Province> provinces;
  final List<Industry> industries;
  List<Activity> activities;
  List<Education> educations;
  List<Certificate> certificates;
  List<Experience> experiences;
  List<Hobby> hobbies;
  List<Project> projects;
  List<Skill> skills;
  List<StudentSkill> studentSkills;
  List<ReferencePerson> referencePeople;
  Message? message;

  CuCVStateData({required this.cv,
    required this.provinces,
    required this.industries,
    required this.skills,
    required this.activities,
    required this.educations,
    required this.certificates,
    required this.experiences,
    required this.hobbies,
    required this.projects,
    required this.studentSkills,
    required this.referencePeople,
    required this.message});

  @override
  List<Object?> get props => [cv, provinces, industries, skills, studentSkills,
    educations, certificates, experiences, hobbies, projects, referencePeople,
    activities,message];
}

class SaveSuccess extends CUCVState {
  final int jobId;

  SaveSuccess({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}
