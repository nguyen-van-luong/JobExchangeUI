import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFieldCustom(String lable, Widget widget) {
  return Container(
    width: 450,
    child: Row(
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.only(right: 10),
          child: Text(lable),
        ),
        widget

      ],
    ),
  );
}