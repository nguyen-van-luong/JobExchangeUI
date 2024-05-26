import 'package:untitled1/models/industry.dart';

import '../models/address.dart';
import '../models/skill.dart';

class JobDto {
  String title;
  DateTime duration;
  int? ageFrom;
  int? ageTo;
  int? salaryFrom;
  int? salaryTo;
  int? quantity;
  String? degree;
  bool? sex;
  String workingForm;
  String experience;
  List<int> skills;
  List<Address> addresses;
  List<int> industries;
  String description;
  String requirement;
  String rights;
  bool isPrivate;

  JobDto({
    required this.title,
    required this.duration,
    required this.ageFrom,
    required this.ageTo,
    required this.salaryFrom,
    required this.salaryTo,
    required this.quantity,
    required this.degree,
    required this.sex,
    required this.workingForm,
    required this.experience,
    required this.addresses,
    required this.skills,
    required this.industries,
    required this.description,
    required this.requirement,
    required this.rights,
    required this.isPrivate,
  });

  Map<String, dynamic> toJson() {
    return{
      'title':  this.title,
      'duration': this.duration.toIso8601String(),
      'ageFrom':  this.ageFrom,
      'ageTo': this.ageTo,
      'salaryFrom':  this.salaryFrom,
      'salaryTo': this.salaryTo,
      'quantity':  this.quantity,
      'degree':  this.degree,
      'sex': this.sex,
      'skills': this.skills,
      'rights': this.rights,
      'workingForm': this.workingForm,
      'experience':  this.experience,
      'addresses': this.addresses.map((address) => address.toJson()).toList(),
      'industries':  this.industries,
      'description': this.description,
      'requirement': this.requirement,
      'private': this.isPrivate,
    };
  }
}