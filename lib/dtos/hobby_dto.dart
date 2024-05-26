class HobbyDto {
  int studentId;
  String name;

  HobbyDto({required this.studentId,
    required this.name});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'name': this.name
    };
  }
}