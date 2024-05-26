import 'package:flutter/cupertino.dart';

Widget buildInfo(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildForm(buildHeader("GIỚI THIỆU"), Text(description, style: TextStyle(fontSize: 16),)),
      buildForm(buildHeader("LIÊN HỆ"), Container())
    ],
  );
}

Widget buildForm(Widget header, Widget body) {
  return Padding(
    padding: EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        header,
        body
      ],
    ),
  );
}

Widget buildHeader(String lable) {
  return Container(
    margin: EdgeInsets.only(left: 16),
    child: Text(lable, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),),
  );
}