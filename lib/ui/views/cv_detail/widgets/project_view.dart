import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/project.dart';

Widget buildProject(List<Project> projects) {
  return Column(
    children: [
      for(var project in projects)
        projectItem(project),
    ],
  );
}

Widget projectItem(Project project) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.company, style: TextStyle(color: Colors.blueAccent),),
        Text('Dự án: ${project.projectName}', style: TextStyle(color: Colors.brown,)),
        Text('${project.description}'),
      ],
    ),
  );
}