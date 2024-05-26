import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headerPage(String lable) {
  return Container(
    padding: EdgeInsets.all(20),
    width: double.infinity,
    color: Colors.white,
    child: Text(
      lable,
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}