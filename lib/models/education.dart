import 'dart:convert';

import 'package:untitled1/models/industry.dart';


class Education {
  int id;
  int studentId;
  String nameSchool;
  Industry industry;
  String period;
  String score;
  String classification;
  DateTime updatedAt;

  Education({required this.id,
    required this.nameSchool,
    required this.studentId,
    required this.industry,
    required this.period,
    required this.score,
    required this.classification,
    required this.updatedAt});

  Education.empty()
      : id = 0,
        studentId = 0,
        nameSchool = '',
        updatedAt = DateTime.now(),
        period = '',
        score = '',
        classification = '',
        industry = Industry.empty();

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      studentId: json['studentId'],
        nameSchool: json['nameSchool'],
      period: json['period'],
      score: json['score'],
      classification: json['classification'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
      industry: Industry.fromJson(json['industry'])
    );
  }

  Education copyWith({
    int? id,
    int? studentId,
    String? nameSchool,
    String? period,
    String? score,
    String? classification,
    Industry? industry,
    DateTime? updatedAt
  }) {
    return Education(
        id: id ?? this.id,
        studentId: studentId ??  this.studentId,
        nameSchool: nameSchool ?? this.nameSchool,
        period: period ?? this.period,
        score: score ?? this.score,
        industry: industry ?? this.industry,
        classification: classification ?? this.classification,
        updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'nameSchool': this.nameSchool,
      'period': this.period,
      'score': this.score,
      'industry': this.industry.toJson(),
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}