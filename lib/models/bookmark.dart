import 'package:flutter/cupertino.dart';
import 'package:untitled1/models/student.dart';

import 'bookmark_id.dart';
import 'job.dart';

@immutable
class Bookmark {
  BookmarkId id;
  Student studentId;
  Job job;
  DateTime updatedAt;

  Bookmark({
    required this.id,
    required this.studentId,
    required this.job,
    required this.updatedAt,
  });

  Bookmark.empty()
      :
        id = BookmarkId.empty(),
        studentId = Student.empty(),
        job = Job.empty(),
        updatedAt = DateTime.now();

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
        id: json['id'] == null ? BookmarkId.empty() : BookmarkId.fromMap(json['id']),
        studentId: json['studentId'] == null ? Student.empty() : Student.fromJson(json['studentId']),
        job: json['job'] == null ? Job.empty() : Job.fromJson(json['job']),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now());
  }
}