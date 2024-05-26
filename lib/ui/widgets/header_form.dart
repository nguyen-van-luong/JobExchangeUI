import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headerForm({required String lable}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black26, width: 2.0),
        )
    ),
    padding: const EdgeInsets.all(10),
    child: Text(
      lable,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}