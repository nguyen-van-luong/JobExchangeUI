
import 'cv.dart';
import 'job.dart';

class Application {
  CV cv;
  Job job;
  String status;
  DateTime createdAt;

  Application({
    required this.cv,
    required this.job,
    required this.status,
    required this.createdAt,
  });

  Application.empty()
      : cv = CV.empty(),
        job = Job.empty(),
        status = '',
        createdAt = DateTime.now();

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
        cv: CV.fromJson(json['cv']),
        job: Job.fromJson(json['job']),
        status: json['status'] ?? '',
        createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
            : DateTime.now());
  }
}