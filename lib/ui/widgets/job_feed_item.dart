import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/ui/router.dart';
import 'package:untitled1/ui/widgets/user_avatar.dart';

import '../../models/address.dart';
import '../../models/job.dart';
import '../common/utils/date_time.dart';

class JobFeedItem extends StatelessWidget {
  final Job job;
  final bool isBorder;

  const JobFeedItem({super.key, required this.job, this.isBorder = false});

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
            onTap: () => appRouter.go("/employer/${job.employer.id}"),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: UserAvatar(
                  imageUrl: job.employer!.avatarUrl,
                  size: 64,
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: InkWell(
                            onTap: () => appRouter.go("/employer/${job.employer.id}"),
                            child: Text(
                              job.employer.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.indigo[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ),
                        const SizedBox(width: 12),
                        Text(
                          getTimeAgo(job.updatedAt),
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
                    onTap: () => appRouter.go("/job/${job.id}"),
                    hoverColor: Colors.black12,
                    child: Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Row(children: [
                      salaryView(job.salaryFrom, job.salaryTo),
                      const SizedBox(width: 16),
                      addressView(job.addresses)
                    ]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget salaryView(int? salaryFrom, int? salaryTo) {
    String text = "";
    if(salaryFrom != null && salaryTo != null) {
      text = salaryFrom.toString() + " - " +salaryTo.toString() + " triệu";
    } else {
      text = (salaryFrom.toString() ?? "") + (salaryTo.toString() ?? "") + " triệu";
    }

    return Container(
      child: Row(
        children: [
          Icon(
            Icons.attach_money,
            size: 16,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 2),
          Text(text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget addressView(List<Address> addresses) {
    String text = addresses[0].province.name;
    if(addresses.length > 1) {
      text += ' & ${addresses.length - 1} nơi khác';
    }

    return Container(
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 16,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 2),
          Text(text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
