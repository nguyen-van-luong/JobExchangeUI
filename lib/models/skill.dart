import 'dart:convert';

import 'package:untitled1/models/industry.dart';

class Skill {
  int id;
  String name;
  List<int> fatherSkillIds;
  List<int> subSkillIds;
  DateTime updatedAt;

  Skill({required this.id, required this.name, required this.fatherSkillIds, required this.subSkillIds, required this.updatedAt});

  Skill.empty()
      : id = 0,
        fatherSkillIds = [],
        name = '',
        updatedAt = DateTime.now(),
        subSkillIds = [];

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      fatherSkillIds: json['fatherSkillIds'] == null ? [] : (json['fatherSkillIds'] as List<dynamic>).map((e) => e as int).toList(),
      subSkillIds: json['subSkillIds'] == null ? [] : (json['subSkillIds'] as List<dynamic>).map((e) => e as int).toList(),
      name: json['name'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Skill copyWith({
    int? id,
    List<int>? fatherSkillIds,
    String? name,
    List<int>? subSkillIds,
    DateTime? updatedAt
  }) {
    return Skill(
      id: id ?? this.id,
      fatherSkillIds: fatherSkillIds ??  this.fatherSkillIds,
      name: name ?? this.name,
      subSkillIds: subSkillIds ?? this.subSkillIds,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'fatherSkillIds': this.fatherSkillIds,
      'name': this.name,
      'subSkillIds': this.subSkillIds,
      'updatedAt': this.updatedAt.toIso8601String()
    };
  }
}