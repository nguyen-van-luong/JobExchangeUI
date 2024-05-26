import '../models/industry.dart';

class EducationDto {
  int studentId;
  String nameSchool;
  Industry industry;
  String period;
  String score;
  String classification;

  EducationDto({required this.studentId,
    required this.nameSchool,
    required this.industry,
    required this.period,
    required this.score,
    required this.classification});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'nameSchool': this.nameSchool,
      'industry': this.industry.toJson(),
      'period': this.period,
      'score': this.score,
      'classification': this.classification
    };
  }
}