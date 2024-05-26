import 'dart:convert';

class ReferencePerson {
  int id;
  int studentId;
  String company;
  String position;
  String name;
  String phoneNumber;
  DateTime updatedAt;

  ReferencePerson({required this.id,
    required this.company,
    required this.studentId,
    required this.position,
    required this.name,
    required this.phoneNumber,
    required this.updatedAt});

  ReferencePerson.empty()
      : id = 0,
        studentId = 0,
        company = '',
        position = '',
        name = '',
        updatedAt = DateTime.now(),
        phoneNumber = '';

  factory ReferencePerson.fromJson(Map<String, dynamic> json) {
    return ReferencePerson(
      id: json['id'],
      studentId: json['studentId'],
      company: json['company'],
      position: json['position'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  ReferencePerson copyWith({
    int? id,
    int? studentId,
    String? company,
    String? name,
    String? position,
    String? phoneNumber,
    DateTime? updatedAt
  }) {
    return ReferencePerson(
        id: id ?? this.id,
        studentId: studentId ??  this.studentId,
        company: company ?? this.company,
        name: name ?? this.name,
        position: position ?? this.position,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'company': this.company,
      'name': this.name,
      'position': this.position,
      'phoneNumber': this.phoneNumber,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}