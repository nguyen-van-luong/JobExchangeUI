class ApplicationId {
  final String cvId;
  final String jobId;

  const ApplicationId({
    required this.cvId,
    required this.jobId,
  });
  // Phương thức tạo FollowId rỗng
  factory ApplicationId.empty() {
    return ApplicationId(cvId: '', jobId: '');
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ApplicationId &&
              runtimeType == other.runtimeType &&
              cvId == other.cvId &&
              jobId == other.jobId;

  @override
  int get hashCode => cvId.hashCode ^ jobId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'cvId': cvId,
      'jobId': jobId,
    };
  }

  factory ApplicationId.fromMap(Map<String, dynamic> map) {
    return ApplicationId(
      cvId: map['cvId'],
      jobId: map['jobId'],
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'cvId': this.cvId,
      'jobId': this.jobId,
    };
  }
}