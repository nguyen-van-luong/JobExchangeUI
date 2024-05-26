import 'package:untitled1/models/student.dart';

import 'job.dart';

class EmployerNotification {
  int id;
  int employerId;
  Student studentId;
  String message;
  bool isRead;
  Job target;
  DateTime sendAt;

  EmployerNotification({
    required this.id,
    required this.studentId,
    required this.employerId,
    required this.message,
    required this.isRead,
    required this.target,
    required this.sendAt,
  });

  EmployerNotification.empty()
      : id = 0,
        studentId = Student.empty(),
        employerId = 0,
        message = '',
        isRead = true,
        target = Job.empty(),
        sendAt = DateTime.now();

  factory EmployerNotification.fromJson(Map<String, dynamic> json) {
    return EmployerNotification(
        id: json['id'],
        studentId: Student.fromJson(json['studentId']),
        employerId: json['employerId'],
        sendAt: DateTime.tryParse(json['sendAt']) ?? DateTime.now(),
        message: json['message'],
        target: Job.fromJson(json['target']),
        isRead: json['read']
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'studentId': this.studentId.toJson(),
      'employerId': this.employerId,
      'sendAt':  this.sendAt?.toIso8601String(),
      'message': this.message,
      'target': this.target,
      'read': this.isRead
    };
  }

  EmployerNotification copyWith({
    int? id,
    Student? studentId,
    int? employerId,
    DateTime? sendAt,
    String? message,
    Job? target,
    bool? isRead
  }) {
    return EmployerNotification(
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