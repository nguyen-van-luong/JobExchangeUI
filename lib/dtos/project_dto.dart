class ProjectDto {
  int studentId;
  String company;
  String projectName;
  String description;

  ProjectDto({required this.studentId,
    required this.company,
    required this.projectName,
    required this.description});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'company': this.company,
      'projectName': this.projectName,
      'description': this.description
    };
  }
}