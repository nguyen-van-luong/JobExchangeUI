import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../models/skill.dart';

Widget skillDropDown(
    List<Skill> skills,
    Skill? skill,
    String hintText,
    String? Function(Skill?) validator,
    Function(Skill?) onchange
    ) {
  final List<DropdownMenuItem<Skill>> skillItems = skills.map((Skill e) {
    return DropdownMenuItem(
      value: e,
      child: Text(
        '${e.name}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }).toList();

  return DropdownButtonFormField<Skill>(
    isExpanded: true,
    menuMaxHeight: 600,
    value: skill,
    hint: Text(hintText),
    validator: validator,
    onChanged: onchange,
    items: skillItems,
  );
}