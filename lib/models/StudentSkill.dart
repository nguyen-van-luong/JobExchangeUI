import 'package:untitled1/models/skill.dart';
import 'package:untitled1/models/skill.dart';

class StudentSkill {
  int id;
  int studentId;
  Skill skill;
  String level;
  DateTime updatedAt;

  StudentSkill({required this.id, required this.studentId, required this.skill, required this.level, required this.updatedAt});

  StudentSkill.empty()
      : id = 0,
        studentId = 0,
        skill = Skill.empty(),
        updatedAt = DateTime.now(),
        level = '';

  factory StudentSkill.fromJson(Map<String, dynamic> json) {
    return StudentSkill(
      id: json['id'],
      studentId: json['studentId'],
      skill: Skill.fromJson(json['skill']),
      level: json['level'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  StudentSkill copyWith({
    int? id,
    int? studentId,
    Skill? skill,
    String? level,
    DateTime? updatedAt
  }) {
    return StudentSkill(
      id: id ?? this.id,
      studentId: studentId ??  this.studentId,
      skill: skill ?? this.skill,
      level: level ?? this.level,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'skill': this.skill.toJson(),
      'level': this.level,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}