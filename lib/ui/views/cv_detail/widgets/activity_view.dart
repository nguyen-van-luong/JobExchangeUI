import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/activity.dart';

Widget buildActivity(List<Activity> activities) {
  return Column(
    children: [
      for(var activity in activities)
        activityItem(activity),
    ],
  );
}

Widget activityItem(Activity activity) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(activity.name, style: TextStyle(color: Colors.blueAccent),),
        Text('${activity.position}', style: TextStyle(color: Colors.brown,)),
        Text('${activity.description}'),
      ],
    ),
  );
}