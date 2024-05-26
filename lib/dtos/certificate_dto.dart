class CertificateDto {
  int studentId;
  String name;

  CertificateDto({required this.studentId, required this.name});

  Map<String, dynamic> toJson() {
    return{
      'studentId': this.studentId,
      'name': name
    };
  }
}