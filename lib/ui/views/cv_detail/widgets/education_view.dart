import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/education.dart';
import 'package:untitled1/ui/common/utils/function_util.dart';

Widget buildEducation(List<Education> educations) {
  return Column(
    children: [
      for(var education in educations)
        educationItem(education),
    ],
  );
}

Widget educationItem(Education education) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(education.period),
        Text(education.nameSchool, style: TextStyle(color: Colors.blueAccent),),
        Text('Ngành học: ${education.industry.name}', style: TextStyle(color: Colors.brown,)),
        Text('Xếp loại: ${education.classification}'),
        Text('Điểm trung bình: ${education.score}'),
      ],
    ),
  );
}