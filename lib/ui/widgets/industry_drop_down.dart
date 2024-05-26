import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/industry.dart';

Widget industryDropDown(List<Industry> industries, Industry? industry, String hintText, String? Function(Industry?) validator,Function(Industry?) onchange) {
  final List<DropdownMenuItem<Industry>> industryItems = industries.map((Industry industry) {
    return DropdownMenuItem(
      value: industry,
      child: Text(
        '${industry.name}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    );
  }).toList();

  return DropdownButtonFormField<Industry>(
    menuMaxHeight: 600,
    value: industry,
    hint: Text(hintText),
    validator: validator,
    onChanged: onchange,
    items: industryItems,
  );
}