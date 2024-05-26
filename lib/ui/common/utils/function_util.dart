import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    // Cập nhật ngày đã chọn vào _dateController
    controller.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}

String? validateTime(String? value) {
  if(value == null || value.isEmpty)
    return "Vui long nhập nội dung";

  final RegExp regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$');
  if (!regex.hasMatch(value!)) {
    return '"$value" không theo định dạng MM/yyyy';
  }
  return null;
}

String? validateTimeStartAndEnd(String? timeStart, String? timeEnd) {
  String? checkTime = validateTime(timeEnd);
  if(checkTime != null)
    return checkTime;
  checkTime = validateTime(timeStart);
  if(checkTime == null) {
    DateTime dateStart = DateTime.parse(timeStart!.split('/').reversed.join() + '-01');
    DateTime dateEnd = DateTime.parse(timeEnd!.split('/').reversed.join() + '-01');
    print(dateEnd.toString());

    if(dateEnd.isBefore(dateStart))
      return "Thời gian kết thúc phải lớn hơn thời gian bắt đầu";
  }
  return null;
}