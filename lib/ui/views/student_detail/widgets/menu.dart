import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/navigation.dart';
import '../../../router.dart';

class Menu extends StatelessWidget {
  final List<Navigation> listSelectBtn;

  const Menu({required this.listSelectBtn});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listSelectBtn.map((selectBtn) {
          return buildButton(selectBtn.index);
        }).toList(),
      ),
    );
  }

  Widget buildButton(int index) {
    return Container(
      width: 150,
      decoration: listSelectBtn[index].isSelected ? BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: Colors.blueAccent))) : BoxDecoration(),
      child: TextButton(
        child:  Align(
          alignment: Alignment.centerLeft,
          child: Text(listSelectBtn[index].text,
            style: TextStyle(color: Colors.black, fontSize: 18),),
        ),
        onPressed: () => appRouter.go(listSelectBtn[index].path, extra: {}),
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          textStyle: TextStyle(fontSize: 16),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }

}