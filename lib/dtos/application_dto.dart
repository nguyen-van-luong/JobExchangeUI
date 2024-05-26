class ApplicationDto {
  int jobId;
  int cvId;
  String status;
  ApplicationDto({required this.jobId, required this.cvId, required this.status});

  Map<String, dynamic> toJson() {
    return{
      'jobId': this.jobId,
      'cvId': cvId,
      'status': status
    };
  }
}