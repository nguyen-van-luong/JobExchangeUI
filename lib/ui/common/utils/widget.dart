
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/ui/common/utils/function_util.dart';

import '../../../models/cv.dart';
import '../../../models/job.dart';
import '../../../models/province.dart';
import '../../widgets/cv_feed_item.dart';
import '../../widgets/job_feed_item.dart';

Widget textFieldNumber(TextEditingController controller, String? Function(String? value) validator, [double size = 120]) {
  return SizedBox(
    width: size,
    child: TextFormField(
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      decoration: const InputDecoration(
        labelStyle: TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),

    ),
  );
}

Widget textFieldDate(BuildContext context,
    TextEditingController controller,
    String hintText,
    String? Function(String? value) validator) {
  return SizedBox(
    width: 280,
    child: TextFormField(
      validator: validator,
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      readOnly: true, // Đặt TextField ở chế độ chỉ đọc
      onTap: () => selectDate(context, controller),
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: const TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),
    ),
  );
}

Widget textForm(TextEditingController controller) {
  return Container(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        top: 16,
      ),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập nội dung';
                }
                return null;
              },
              maxLines: null,
              decoration: const InputDecoration.collapsed(
                hintText: 'Viết nội dung ở đây...',
              ),
              onChanged: (value) {
              },
            ),
          )
        ],
      ));
}

void _defaultOnSelect(String? value) {}

Widget menuDropDown(List<String> strs, TextEditingController controller, [void Function(String?) onSelect = _defaultOnSelect]) {
  final List<DropdownMenuEntry<String>> strEntries = strs.map((String str) {
    return DropdownMenuEntry<String>(
      value: str,
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${str}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            maxLines: 1,
          ),
        ],
      ),
      label: str,
    );
  }).toList();

  return DropdownMenu<String>(
    controller: controller,
    enableFilter: true,
    initialSelection: null,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    hintText: "Chọn",
    onSelected: onSelect,
    dropdownMenuEntries: strEntries,
  );
}

Widget menuDropDownForm(List<String> strs,
    String? str,
    String hintText,
    String? Function(String?) validator,
    Function(String?) onChange) {
  final List<DropdownMenuItem<String>> strItems = strs.map((String str) {
    return DropdownMenuItem<String>(
      value: str,
      child: Text(
        '${str}',
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

  return DropdownButtonFormField<String>(
    value: str,
    hint: Text(hintText),
    validator: validator,
    onChanged: onChange,
    items: strItems,
  );
}

Widget textField(TextEditingController controller) {
  return SizedBox(
    width: 280,
    child: TextField(
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      decoration: const InputDecoration(
        labelStyle: TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),
    ),
  );
}

Widget textFormField(TextEditingController controller, String hintText, String? Function(String? value) validator) {
  return SizedBox(
    width: 280,
    child: TextFormField(
      validator: validator,
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: const TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),
    ),
  );
}

Widget proviceDropDown(List<Province> provinces, TextEditingController controller, String hintText, Function(Province?) onSelect) {
  List<DropdownMenuEntry<Province>> provinceEntries = provinces.map((Province province) {
    return DropdownMenuEntry<Province>(
      value: province,
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${province.name}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            maxLines: 1,
          ),
        ],
      ),
      label: province.name,
    );
  }).toList();

  return DropdownMenu<Province>(
    controller: controller,
    enableFilter: true,
    initialSelection: null,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    hintText: hintText,
    dropdownMenuEntries: provinceEntries,
    onSelected: onSelect,
  );
}

Widget proviceDropDownForm(List<Province> provinces,
    Province? province,
    String hintText,
    String? Function(Province?) validator,
    Function(Province?) onChange) {
  List<DropdownMenuItem<Province>> provinceItems = provinces.map((Province province) {
    return DropdownMenuItem<Province>(
      value: province,
      child: Text(
        '${province.name}',
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

  return DropdownButtonFormField<Province>(
    value: province,
    menuMaxHeight: 600,
    hint: Text(hintText),
    validator: validator,
    onChanged: onChange,
    items: provinceItems,
  );
}

Widget buildItemJobRow(Job itemOne, Job? itemTow, [bool isBorder = false]) {
  return Row(
    children: [
      Expanded(
        child: JobFeedItem(job: itemOne, isBorder: isBorder),
      ),
      Expanded(
        child: itemTow != null ? JobFeedItem(job: itemTow,  isBorder: isBorder) : Container(),
      )
    ],
  );
}

Widget buildItemCVRow(CV itemOne, CV? itemTow, [bool isBorder = false]) {
  return Row(
    children: [
      Expanded(
        child: CVFeedItem(cv: itemOne, isBorder: isBorder),
      ),
      Expanded(
        child: itemTow != null ? CVFeedItem(cv: itemTow, isBorder: isBorder) : Container(),
      )
    ],
  );
}