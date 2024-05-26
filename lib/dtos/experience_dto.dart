class ExperienceDto {
  int studentId;
  String company;
  String position;
  String period;
  String description;

  ExperienceDto({required this.studentId,
    required this.company,
    required this.period,
    required this.position,
    required this.description});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'company': this.company,
      'position': this.position,
      'period': this.period,
      'description': this.description
    };
  }
}