import 'package:untitled1/models/activity.dart';
import 'package:untitled1/models/certificate.dart';
import 'package:untitled1/models/education.dart';
import 'package:untitled1/models/experience.dart';
import 'package:untitled1/models/hobby.dart';
import 'package:untitled1/models/industry.dart';
import 'package:untitled1/models/project.dart';
import 'package:untitled1/models/province.dart';
import 'package:untitled1/models/reference_person.dart';
import 'package:untitled1/models/skill.dart';
import 'package:untitled1/models/student.dart';

import 'StudentSkill.dart';


class CV {
  int id;
  Student student;
  String? avatar;
  String fullname;
  DateTime birthday;
  String email;
  Province province;
  String address;
  bool? sex;
  String phoneNumber;
  String positionWant;
  String? yearOfExperience;
  int? salaryWant;
  String? careerObjective;
  String? workingForm;
  List<StudentSkill> studentSkills;
  List<Industry> industries;
  List<Activity> activities;
  List<Certificate> certificates;
  List<Education> educations;
  List<Experience> experiences;
  List<Hobby> hobbies;
  List<Project> projects;
  List<ReferencePerson> referencePeople;
  bool isPrivate;
  DateTime updatedAt;

  CV({
    required this.id,
    required this.student,
    required this.fullname,
    required this.province,
    required this.address,
    required this.email,
    required this.avatar,
    required this.salaryWant,
    required this.positionWant,
    required this.workingForm,
    required this.yearOfExperience,
    required this.phoneNumber,
    required this.sex,
    required this.birthday,
    required this.updatedAt,
    required this.isPrivate,
    required this.careerObjective,
    required this.studentSkills,
    required this.experiences,
    required this.activities,
    required this.industries,
    required this.certificates,
    required this.educations,
    required this.hobbies,
    required this.projects,
    required this.referencePeople
  });

  CV.empty()
      : id = 0,
        student = Student.empty(),
        fullname = '',
        birthday = DateTime.now(),
        phoneNumber = '',
        positionWant = '',
        salaryWant = null,
        email = '',
        province = Province.empty(),
        address = '',
        workingForm = '',
        sex = null,
        isPrivate = true,
        updatedAt = DateTime.now(),
        avatar = null,
        careerObjective = '',
        yearOfExperience = '',
        studentSkills = [],
        industries = [],
        referencePeople = [],
        projects = [],
        hobbies = [],
        educations = [],
        certificates = [],
        activities = [],
        experiences = [];

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      id: json['id'],
      student: Student.fromJson(json['student']),
      fullname: json['fullname'],
      birthday: DateTime.tryParse(json['birthday']) ?? DateTime.now(),
      email: json['email'],
      province: Province.fromJson(json['province']),
      address: json['address'],
      sex: json['sex'],
      phoneNumber: json['phoneNumber'],
      positionWant: json['positionWant'],
      salaryWant: json['salaryWant'],
      workingForm: json['workingForm'],
      isPrivate: json['isPrivate'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
      avatar: json['avatar'],
      careerObjective: json['careerObjective'],
      yearOfExperience: json['yearOfExperience'],
      referencePeople: (json['referencePeople'] as List<dynamic>).map((e) => ReferencePerson.fromJson(e)).toList(),
      projects: (json['projects'] as List<dynamic>).map((e) => Project.fromJson(e)).toList(),
      hobbies: (json['hobbies'] as List<dynamic>).map((e) => Hobby.fromJson(e)).toList(),
      studentSkills: (json['studentSkills'] as List<dynamic>)
        .map((e) => StudentSkill.fromJson(e))
        .toList(),
      industries: (json['industries'] as List<dynamic>)
        .map((e) => Industry.fromJson(e))
        .toList(),
      educations: (json['educations'] as List<dynamic>).map((e) => Education.fromJson(e)).toList(),
      certificates: (json['certificates'] as List<dynamic>).map((e) => Certificate.fromJson(e)).toList(),
      activities: (json['activities'] as List<dynamic>).map((e) => Activity.fromJson(e)).toList(),
      experiences: (json['experiences'] as List<dynamic>).map((e) => Experience.fromJson(e)).toList()
    );
  }

  CV copyWith({
    int? id,
    String? avatar,
    Student? student,
    String? fullname,
    DateTime? birthday,
    String? email,
    Province? province,
    String? address,
    bool? sex,
    String? phoneNumber,
    String? positionWant,
    String? yearOfExperience,
    int? salaryWant,
    String? careerObjective,
    String? workingForm,
    List<StudentSkill>? studentSkills,
    List<Industry>? industries,
    List<Activity>? activities,
    List<Certificate>? certificates,
    List<Education>? educations,
    List<Experience>? experiences,
    List<Hobby>? hobbies,
    List<ReferencePerson>? referencePeople,
    List<Project>? projects,
    bool? isPrivate,
    DateTime? updatedAt,
  }) {
    return CV(
      id: id ?? this.id,
      student: student ?? this.student,
      fullname: fullname ?? this.fullname,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      province: province ?? this.province,
      address: address ?? this.address,
      sex: sex ?? this.sex,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      positionWant: positionWant ?? this.positionWant,
      yearOfExperience: yearOfExperience ?? this.yearOfExperience,
      careerObjective: careerObjective ?? this.careerObjective,
      salaryWant: salaryWant ?? this.salaryWant,
      workingForm: workingForm ?? this.workingForm,
      studentSkills: studentSkills ?? this.studentSkills,
      industries: industries ?? this.industries,
      activities: activities ?? this.activities,
      certificates: certificates ?? this.certificates,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      hobbies: hobbies ?? this.hobbies,
      referencePeople: referencePeople ?? this.referencePeople,
      projects: projects ?? this.projects,
      isPrivate: isPrivate ?? this.isPrivate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}