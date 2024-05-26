import 'package:flutter/cupertino.dart';

class Navigation {
  final int index;
  String text;
  bool isSelected;
  String path;
  Widget widget;

  Navigation(
      {required this.index,
        this.text = "",
        this.isSelected = false,
        this.path = "",
        required this.widget});
}