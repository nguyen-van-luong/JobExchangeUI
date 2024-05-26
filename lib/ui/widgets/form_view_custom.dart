import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/utils/widget.dart';
import 'header_form.dart';

Widget buildFormView(String lable, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 40),
    color: Colors.white,
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        headerForm(lable: lable),
        textForm(controller),
      ],
    ),
  );
}