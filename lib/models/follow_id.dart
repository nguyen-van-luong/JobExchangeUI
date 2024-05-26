class FollowId {
  final int studentId;
  final int employerId;

  const FollowId({
    required this.studentId,
    required this.employerId,
  });
  // Phương thức tạo FollowId rỗng
  factory FollowId.empty() {
    return FollowId(studentId: 0, employerId: 0);
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FollowId &&
              runtimeType == other.runtimeType &&
              studentId == other.studentId &&
              employerId == other.employerId;

  @override
  int get hashCode => studentId.hashCode ^ employerId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'employerId': employerId,
    };
  }

  factory FollowId.fromMap(Map<String, dynamic> map) {
    return FollowId(
      studentId: map['studentId'],
      employerId: map['employerId'],
    );
  }
}