import 'dart:convert';

class SkillDto {
  String name;
  List<int> fatherSkillId;
  List<int> subSkillId;
  SkillDto({required this.name, required this.fatherSkillId, required this.subSkillId});

  Map<String, dynamic> toJson() {
    return{
      'name':  this.name,
      'fatherSkillId': this.fatherSkillId,
      'subSkillId': this.subSkillId
    };
  }
}