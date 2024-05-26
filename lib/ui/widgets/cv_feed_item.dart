import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/ui/router.dart';
import 'package:untitled1/ui/widgets/user_avatar.dart';

import '../../models/cv.dart';
import '../common/utils/date_time.dart';

class CVFeedItem extends StatelessWidget {
  final CV cv;
  final bool isBorder;

  const CVFeedItem({super.key, required this.cv, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return _buildContainer();
  }

  Container _buildContainer() {
    return Container(
      decoration: isBorder ? BoxDecoration(
          border: Border.all(width: 1, color: Colors.black38),
          borderRadius: BorderRadius.circular(8)
      ) : BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => appRouter.go("/student/${cv.student.id}"),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: UserAvatar(
                  imageUrl: cv.student!.avatarUrl,
                  size: 64,
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => appRouter.go("/student/${cv.student.id}"),
                          child: Text(
                            cv.student.fullname,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.indigo[700]),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          getTimeAgo(cv.updatedAt),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                  child: InkWell(
                    onTap: () => appRouter.go("/cv/${cv.id}"),
                    hoverColor: Colors.black12,
                    child: Text(
                      cv.positionWant,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}