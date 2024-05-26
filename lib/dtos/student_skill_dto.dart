class StudentSkillDto {
  int skillId;
  int studentId;
  String level;
  StudentSkillDto({required this.skillId, required this.studentId, required this.level});

  Map<String, dynamic> toJson() {
    return{
      'skillId':  this.skillId,
      'studentId': this.studentId,
      'level': this.level
    };
  }
}