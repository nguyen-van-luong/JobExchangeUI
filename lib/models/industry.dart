import 'dart:convert';

class Industry {
  int id;
  String name;
  List<int> fatherIndustryIds;
  List<int> subIndustryIds;
  DateTime? updatedAt;

  Industry({
    required this.id,
    required this.name,
    required this.fatherIndustryIds,
    required this.subIndustryIds,
    required this.updatedAt,
  });

  Industry.empty()
      : id = 0,
        name = '',
        fatherIndustryIds = [],
        subIndustryIds = [],
        updatedAt = null;

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(
      id: json['id'],
      name: json['name'],
      fatherIndustryIds:json['fatherIndustryIds'] == null ? [] : (json['fatherIndustryIds'] as List<dynamic>).map((e) => e as int).toList(),
      subIndustryIds:json['subIndustries'] == null ? [] : (json['subIndustries'] as List<dynamic>).map((e) => e as int).toList(),
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Industry copyWith({
    int? id,
    String? name,
    List<int>? fatherIndustryIds,
    List<int>? subIndustryIds,
    DateTime? updatedAt
  }) {
    return Industry(
      id: id ?? this.id,
      name: name ?? this.name,
      fatherIndustryIds: fatherIndustryIds ?? this.fatherIndustryIds,
      subIndustryIds: subIndustryIds ?? this.subIndustryIds,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'name': this.name,
      'fatherIndustryIds': this.fatherIndustryIds,
      'subIndustryIds': this.subIndustryIds,
      'updatedAt':  this.updatedAt?.toIso8601String(),
    };
  }
}
