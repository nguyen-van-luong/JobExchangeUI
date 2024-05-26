import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/StudentSkill.dart';
import 'package:untitled1/models/activity.dart';
import 'package:untitled1/models/certificate.dart';
import 'package:untitled1/models/education.dart';
import 'package:untitled1/models/experience.dart';
import 'package:untitled1/models/hobby.dart';
import 'package:untitled1/models/project.dart';
import 'package:untitled1/models/reference_person.dart';
import 'package:untitled1/models/skill.dart';
import 'package:untitled1/repositories/education_repository.dart';
import 'package:untitled1/repositories/skill_repository.dart';
import 'package:untitled1/repositories/student_skill_repository.dart';
import 'package:untitled1/ui/router.dart';

import '../../../../../dtos/cv_dto.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../models/cv.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/province.dart';
import '../../../../../repositories/activity_repository.dart';
import '../../../../../repositories/certificate_repository.dart';
import '../../../../../repositories/cv_repository.dart';
import '../../../../../repositories/experience_repository.dart';
import '../../../../../repositories/hobby_repository.dart';
import '../../../../../repositories/industry_repository.dart';
import '../../../../../repositories/project_repository.dart';
import '../../../../../repositories/province_repository.dart';
import '../../../../../repositories/reference_person_repository.dart';
import '../../../../common/utils/message_from_exception.dart';

part 'cu_cv_event.dart';
part 'cu_cv_state.dart';

class CUCVBloc extends Bloc<CUCVEvent, CUCVState> {
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();
  StudentSkillRepository studentSkillRepository = StudentSkillRepository();
  CVRepository cvRepository = CVRepository();
  ActivityRepository activityRepository = ActivityRepository();
  EducationRepository educationRepository = EducationRepository();
  CertificateRepository certificateRepository = CertificateRepository();
  ExperienceRepository experienceRepository = ExperienceRepository();
  HobbyRepository hobbyRepository = HobbyRepository();
  ProjectRepository projectRepository = ProjectRepository();
  SkillRepository skillRepository = SkillRepository();
  ReferencePersonRepository referencePersonRepository = ReferencePersonRepository();

  CUCVBloc() : super(CUCVInitialState()) {
    on<LoadEvent>(_onLoad);
    on<SaveEvent>(_onSave);
    on<UpdateEvent>(_onUpdate);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<CUCVState> emit) async {
    CV? cv = null;
    Response<dynamic> response;

    if(event.id != null) {
      response = await cvRepository.getById(id: '${event.id}');
      cv = CV.fromJson(response.data);
    }

    response = await industryRepository.getAll();

    List<Industry> industries = response.data == null ? [] : response.data.map<Industry>((e) => Industry.fromJson(e as Map<String, dynamic>)).toList();

    response = await provinceRepository.getAll();
    List<Province> provinces = response.data == null ? [] : response.data.map<Province>((e) => Province.fromJson(e as Map<String, dynamic>)).toList();
    response = await activityRepository.getByStudent();
    List<Activity> activities = response.data == null ? [] : response.data.map<Activity>((e) => Activity.fromJson(e as Map<String, dynamic>)).toList();
    response = await educationRepository.getByStudent();
    List<Education> educations = response.data == null ? [] : response.data.map<Education>((e) => Education.fromJson(e as Map<String, dynamic>)).toList();
    response = await certificateRepository.getByStudent();
    List<Certificate> certificates = response.data == null ? [] : response.data.map<Certificate>((e) => Certificate.fromJson(e as Map<String, dynamic>)).toList();
    response = await experienceRepository.getByStudent();
    List<Experience> experiences = response.data == null ? [] : response.data.map<Experience>((e) => Experience.fromJson(e as Map<String, dynamic>)).toList();
    response = await hobbyRepository.getByStudent();
    List<Hobby> hobbies = response.data == null ? [] : response.data.map<Hobby>((e) => Hobby.fromJson(e as Map<String, dynamic>)).toList();
    response = await projectRepository.getByStudent();
    List<Project> projects = response.data == null ? [] : response.data.map<Project>((e) => Project.fromJson(e as Map<String, dynamic>)).toList();
    response = await referencePersonRepository.getByStudent();
    List<ReferencePerson> referencePeople = response.data == null ? [] : response.data.map<ReferencePerson>((e) => ReferencePerson.fromJson(e as Map<String, dynamic>)).toList();
    response = await studentSkillRepository.getByStudent();
    List<StudentSkill> studentSkills = response.data == null ? [] : response.data.map<StudentSkill>((e) => StudentSkill.fromJson(e)).toList();
    response = await skillRepository.getAll();
    List<Skill> skills = response.data == null ? [] : response.data.map<Skill>((e) => Skill.fromJson(e as Map<String, dynamic>)).toList();

    emit(CuCVStateData(cv: cv,
        industries: industries,
        provinces: provinces,
        activities: activities,
        educations: educations,
        certificates: certificates,
        experiences: experiences,
        hobbies: hobbies,
        projects: projects,
        skills: skills,
        studentSkills: studentSkills,
        referencePeople: referencePeople,
        message: null));
  }

  Future<void> _onSave(
      SaveEvent event, Emitter<CUCVState> emit) async {
    try {
      var future = cvRepository.save(event.cv);
      await future.then((response) {
        CV cv = CV.fromJson(response.data);
        appRouter.go('/cv/${cv.id}');
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(Message(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdate(
      UpdateEvent event, Emitter<CUCVState> emit) async {
    try {
      var future = cvRepository.update(id: event.id, cvDto: event.cv);

      await future.then((response) {
        appRouter.go('/cv/${event.id}');
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(Message(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }
}