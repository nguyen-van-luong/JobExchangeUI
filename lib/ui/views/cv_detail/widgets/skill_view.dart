import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/StudentSkill.dart';

import '../../../../models/skill.dart';

Widget buildSkill(List<StudentSkill> skills) {
  return Column(
    children: [
      for(var skill in skills)
        skillItem(skill),
    ],
  );
}

Widget skillItem(StudentSkill skill) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(skill.skill.name, softWrap: true, style: TextStyle(color: Colors.grey[700],))),
        Text(skill.level, style: TextStyle(color: Colors.grey[700],))
      ],
    ),
  );
}