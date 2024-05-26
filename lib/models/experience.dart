import 'dart:convert';

class Experience {
  int id;
  int studentId;
  String company;
  String position;
  String period;
  String description;
  DateTime updatedAt;

  Experience({required this.id,
    required this.company,
    required this.studentId,
    required this.position,
    required this.period,
    required this.description,
    required this.updatedAt});

  Experience.empty()
      : id = 0,
        studentId = 0,
        company = '',
        position = '',
        updatedAt = DateTime.now(),
        period = '',
        description = '';

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      studentId: json['studentId'],
      company: json['company'],
      position: json['position'],
      period: json['period'],
      description: json['description'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Experience copyWith({
    int? id,
    int? studentId,
    String? company,
    String? position,
    String? period,
    String? description,
    DateTime? updatedAt,
  }) {
    return Experience(
        id: id ?? this.id,
        studentId: studentId ??  this.studentId,
        company: company ?? this.company,
        period: period ?? this.period,
        position: position ?? this.position,
        description: description ?? this.description,
        updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'company': this.company,
      'period': this.period,
      'position': this.position,
      'description': this.description,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}