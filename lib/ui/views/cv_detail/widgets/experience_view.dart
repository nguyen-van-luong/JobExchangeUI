import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/experience.dart';

Widget buildExperience(String? yearOfWork, List<Experience> experiences) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      yearOfWork == null ? Container() :
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text('Số năm kinh nghiệm: ${yearOfWork}', style: TextStyle(fontSize: 18),),
          ),
      for(var experience in experiences)
        experienceItem(experience),
    ],
  );
}

Widget experienceItem(Experience experience) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(experience.period),
        Text(experience.company, style: TextStyle(color: Colors.blueAccent),),
        Text('Vị trí: ${experience.position}', style: TextStyle(color: Colors.brown,)),
        Text('${experience.description}'),
      ],
    ),
  );
}