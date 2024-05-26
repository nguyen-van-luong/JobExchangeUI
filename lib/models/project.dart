import 'dart:convert';

class Project {
  int id;
  int studentId;
  String company;
  String projectName;
  String description;
  DateTime updatedAt;

  Project({required this.id,
    required this.company,
    required this.studentId,
    required this.projectName,
    required this.description,
    required this.updatedAt});

  Project.empty()
      : id = 0,
        studentId = 0,
        company = '',
        projectName = '',
        updatedAt = DateTime.now(),
        description = '';

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      studentId: json['studentId'],
      company: json['company'],
      projectName: json['projectName'],
      description: json['description'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Project copyWith({
    int? id,
    int? studentId,
    String? company,
    String? projectName,
    String? description,
    DateTime? updatedAt,
  }) {
    return Project(
        id: id ?? this.id,
        studentId: studentId ??  this.studentId,
        company: company ?? this.company,
        projectName: projectName ?? this.projectName,
        description: description ?? this.description,
        updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'company': this.company,
      'projectName': this.projectName,
      'description': this.description,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}