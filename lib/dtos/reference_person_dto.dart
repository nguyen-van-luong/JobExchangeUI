class ReferencePersonDto {
  int studentId;
  String company;
  String position;
  String name;
  String phoneNumber;

  ReferencePersonDto({required this.studentId,
    required this.company,
    required this.position,
    required this.name,
    required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'company': this.company,
      'position': this.position,
      'name': this.name,
      'phoneNumber': this.phoneNumber
    };
  }
}