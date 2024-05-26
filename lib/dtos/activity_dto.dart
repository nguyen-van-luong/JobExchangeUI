class ActivityDto {
  int studentId;
  String name;
  String position;
  String description;

  ActivityDto({required this.studentId, required this.name, required this.position, required this.description});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'name': name,
      'position': position,
      'description': description
    };
  }
}