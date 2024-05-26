import 'dart:convert';

class Activity {
  int id;
  int studentId;
  String name;
  String position;
  String description;
  DateTime updatedAt;

  Activity({required this.id,
    required this.name,
    required this.studentId,
    required this.position,
    required this.description,
    required this.updatedAt});

  Activity.empty()
      : id = 0,
        studentId = 0,
        name = '',
        position = '',
        description = '',
        updatedAt = DateTime.now();

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      studentId: json['studentId'],
      name: json['name'],
      position: json['position'],
      description: json['description'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Activity copyWith({
    int? id,
    int? studentId,
    String? name,
    String? position,
    String? description,
    DateTime? updatedAt
  }) {
    return Activity(
        id: id ?? this.id,
        studentId: studentId ??  this.studentId,
        name: name ?? this.name,
        position: position ?? this.position,
        description: description ?? this.description,
        updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'name': this.name,
      'position': this.position,
      'description': this.description,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}