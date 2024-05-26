import 'package:flutter/material.dart';
import 'package:untitled1/models/hobby.dart';

import '../../../../common/utils/date_time.dart';

Widget buildHobbyFeed(Hobby hobby, IconButton button) {
  return Card(
    margin: EdgeInsets.only(bottom: 12),
    child: Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 350),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Cập nhật: ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.indigo[700]),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            getTimeAgo(hobby.updatedAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2, bottom: 4),
                        child: Text(
                          '${hobby.name}',
                          style: TextStyle(fontSize: 16,),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            child: button,
          )
        ],
      ),
    ),
  );
}