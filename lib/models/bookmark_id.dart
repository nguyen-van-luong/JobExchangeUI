class BookmarkId {
  final int studentId;
  final int jobId;

  const BookmarkId({
    required this.studentId,
    required this.jobId,
  });
  // Phương thức tạo FollowId rỗng
  factory BookmarkId.empty() {
    return BookmarkId(studentId: 0, jobId: 0);
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookmarkId &&
              runtimeType == other.runtimeType &&
              studentId == other.studentId &&
              jobId == other.jobId;

  @override
  int get hashCode => studentId.hashCode ^ jobId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'jobId': jobId,
    };
  }

  factory BookmarkId.fromMap(Map<String, dynamic> map) {
    return BookmarkId(
      studentId: map['studentId'],
      jobId: map['jobId'],
    );
  }
}