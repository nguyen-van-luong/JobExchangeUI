import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormCustom(String lable, TextEditingController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 120,
        padding: const EdgeInsets.only(right: 10),
        child: Text(lable),
      ),
      Expanded(
        child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              top: 16,
              bottom: 16,
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
            )),
      )
    ],
  );
}