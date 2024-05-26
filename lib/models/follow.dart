import 'package:flutter/cupertino.dart';
import 'package:untitled1/models/employer.dart';
import 'package:untitled1/models/follow_id.dart';
import 'package:untitled1/models/student.dart';

@immutable
class Follow {
  FollowId id;
  Student student;
  Employer employer;
  DateTime updatedAt;

  Follow({
    required this.id,
    required this.student,
    required this.employer,
    required this.updatedAt,
  });

  Follow.empty()
      :
        id = FollowId.empty(),
        student = Student.empty(),
        employer = Employer.empty(),
        updatedAt = DateTime.now();

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
        id: json['id'] == null ? FollowId.empty() : FollowId.fromMap(json['id']),
        student: json['student'] == null ? Student.empty() : Student.fromJson(json['student']),
        employer: json['employer'] == null ? Employer.empty() : Employer.fromJson(json['employer']),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now());
  }
}