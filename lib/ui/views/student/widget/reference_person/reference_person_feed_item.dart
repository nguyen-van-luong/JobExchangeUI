import 'package:flutter/material.dart';
import 'package:untitled1/models/reference_person.dart';

import '../../../../common/utils/date_time.dart';

Widget buildReferencePersonFeed(ReferencePerson referencePerson, IconButton button) {
  return Card(
    margin: EdgeInsets.only(bottom: 12),
    child: Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Tooltip(
            richMessage: WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.all(10),
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Text('${referencePerson.position} - ${referencePerson.phoneNumber}'),
                )),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
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
                              getTimeAgo(referencePerson.updatedAt),
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
                            '${referencePerson.name} - ${referencePerson.company}',
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
          ),

          SizedBox(
            child: button,
          )
        ],
      ),
    ),
  );
}