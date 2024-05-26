import 'dart:convert';

import 'package:untitled1/models/province.dart';

class CVDto {
  String? avatar;
  String fullname;
  DateTime birthday;
  String email;
  Province province;
  String address;
  bool? sex;
  String phoneNumber;
  String? positionWant;
  String? yearOfExperience;
  int? salaryWant;
  String? workingForm;
  String careerObjective;
  List<int> studentSkills;
  List<int> industries;
  List<int> activities;
  List<int> certificates;
  List<int> educations;
  List<int> experiences;
  List<int> hobbies;
  List<int> projects;
  List<int> referencePeople;
  bool isPrivate;

  CVDto({
    required this.fullname,
    required this.birthday,
    required this.email,
    required this.province,
    required this.address,
    required this.sex,
    required this.phoneNumber,
    required this.activities,
    required this.positionWant,
    required this.referencePeople,
    required this.projects,
    required this.workingForm,
    required this.studentSkills,
    required this.salaryWant,
    required this.industries,
    required this.experiences,
    required this.hobbies,
    required this.certificates,
    required this.educations,
    required this.yearOfExperience,
    required this.careerObjective,
    required this.avatar,
    required this.isPrivate,
  });

  Map<String, dynamic> toJson() {
    return{
      'avatar': this.avatar,
      'fullname':  this.fullname,
      'birthday': this.birthday.toIso8601String(),
      'email': this.email,
      'province':  this.province.toJson(),
      'address': this.address,
      'sex':  this.sex,
      'phoneNumber': this.phoneNumber,
      'positionWant':  this.positionWant,
      "yearOfExperience": this.yearOfExperience,
      'salaryWant': this.salaryWant,
      'workingForm': this.workingForm,
      'careerObjective':  this.careerObjective,
      'industries':  this.industries,
      'studentSkills': this.studentSkills,
      "educations": this.educations,
      'isPrivate': this.isPrivate,
      'certificates': this.certificates,
      'hobbies': this.hobbies,
      'experiences': this.experiences,
      'projects': this.projects,
      'referencePeople': this.referencePeople,
      'activities': this.activities
    };
  }
}
