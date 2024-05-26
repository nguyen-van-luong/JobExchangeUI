import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/ui/widgets/user_avatar.dart';

import '../../models/student_notification.dart';
import '../../repositories/student_notification_repository.dart';
import '../common/utils/date_time.dart';
import '../router.dart';

class StudentNotificationItem extends StatelessWidget {
  final StudentNotification studentNotification;
  final StudentNotificationRepository _studentNotificationRepository = StudentNotificationRepository();

  StudentNotificationItem({super.key, required this.studentNotification});

  @override
  Widget build(BuildContext context) {
    return _buildContainer( studentNotification);
  }

  Container _buildContainer(StudentNotification studentNotification) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: studentNotification.studentId == 0 ? null :
                    () => appRouter.go("/employer/${studentNotification.employerId.id}"),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserAvatar(
                      imageUrl: studentNotification.employerId!.avatarUrl,
                      size: 48,
                    )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: InkWell(
                        onTap: studentNotification.studentId == 0 ? null :
                            () async {
                              if(studentNotification.isRead == false) {
                                await _studentNotificationRepository.update(id: studentNotification.id);
                              }
                              appRouter.go("/job/" + studentNotification.target.id.toString());
                            },
                        hoverColor: Colors.black12,
                        child: Text(
                          studentNotification.employerId == 0 ?
                          'Thông báo không còn tồn tại' : '${studentNotification.employerId.name} ${studentNotification.message} ${studentNotification.target.title}' ,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: Text(
                        getTimeAgo(studentNotification.sendAt),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],

      ),
    );
  }
}