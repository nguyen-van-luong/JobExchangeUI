import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/employer_notification.dart';
import 'package:untitled1/ui/widgets/user_avatar.dart';

import '../../repositories/employer_notification_repository.dart';
import '../common/utils/date_time.dart';
import '../router.dart';

class EmployerNotificationItem extends StatelessWidget {
  final EmployerNotification employerNotification;
  final EmployerNotificationRepository _employerNotificationRepository = EmployerNotificationRepository();

  EmployerNotificationItem({super.key, required this.employerNotification});

  @override
  Widget build(BuildContext context) {
    return _buildContainer( employerNotification);
  }

  Container _buildContainer(EmployerNotification employerNotification) {
    return Container(
      color: employerNotification.isRead ? Colors.white : Color.fromARGB((0.1 * 255).round(), 0, 0, 0),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: employerNotification.employerId == 0 ? null :
                    () => appRouter.go("/student/${employerNotification.studentId.id}"),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserAvatar(
                      imageUrl: employerNotification.studentId!.avatarUrl,
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
                        onTap: employerNotification.employerId == "" ? null :
                            () async {
                              if(employerNotification.isRead == false) {
                                await _employerNotificationRepository.update(id: employerNotification.id);
                              }
                              appRouter.go("/application");
                            },
                        hoverColor: Colors.black12,
                        child: Text(
                          employerNotification.employerId == 0 ?
                          'Thông báo không còn tồn tại' : '${employerNotification.studentId.fullname} ${employerNotification.message} ${employerNotification.target.title}' ,
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
                        getTimeAgo(employerNotification.sendAt),
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