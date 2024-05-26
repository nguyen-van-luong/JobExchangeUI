import 'package:untitled1/models/employer.dart';

import 'job.dart';

class StudentNotification {
  int id;
  int studentId;
  Employer employerId;
  String message;
  bool isRead;
  Job target;
  DateTime sendAt;

  StudentNotification({
    required this.id,
    required this.studentId,
    required this.employerId,
    required this.message,
    required this.isRead,
    required this.target,
    required this.sendAt,
  });

  StudentNotification.empty()
      : id = 0,
        studentId = 0,
        employerId = Employer.empty(),
        message = '',
        isRead = true,
        target = Job.empty(),
        sendAt = DateTime.now();

  factory StudentNotification.fromJson(Map<String, dynamic> json) {
    return StudentNotification(
        id: json['id'],
        studentId: json['studentId'],
        employerId: Employer.fromJson(json['employerId']),
        sendAt: DateTime.tryParse(json['sendAt']) ?? DateTime.now(),
        message: json['message'],
        target: Job.fromJson(json['target']),
        isRead: json['read']
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId,
      'employerId': this.employerId,
      'sendAt':  this.sendAt?.toIso8601String(),
      'message': this.message,
      'target': this.target,
      'isRead': this.isRead
    };
  }

  StudentNotification copyWith({
    int? id,
    int? studentId,
    Employer? employerId,
    DateTime? sendAt,
    String? message,
    Job? target,
    bool? isRead
  }) {
    return StudentNotification(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        employerId: employerId ?? this.employerId,
        sendAt: sendAt ?? this.sendAt,
        message: message ?? this.message,
        target: target ?? this.target,
        isRead: isRead ?? this.isRead,
    );
  }
}