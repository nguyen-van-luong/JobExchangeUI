import 'dart:convert';

class Hobby {
  int id;
  int studentId;
  String name;
  DateTime updatedAt;

  Hobby({required this.id,
    required this.name,
    required this.studentId,
    required this.updatedAt});

  Hobby.empty()
      : id = 0,
        studentId = 0,
        updatedAt = DateTime.now(),
        name = '';

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json['id'],
      studentId: json['studentId'],
      name: json['name'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Hobby copyWith({
    int? id,
    int? studentId,
    String? name,
    DateTime? updatedAt
  }) {
    return Hobby(
        id: id ?? this.id,
        studentId: studentId ??  this.studentId,
        name: name ?? this.name,
        updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'name': this.name,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}