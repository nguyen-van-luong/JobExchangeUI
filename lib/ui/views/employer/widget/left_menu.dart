
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/navigation.dart';
import '../../../router.dart';


class LeftMenu extends StatelessWidget {
  final List<Navigation> listSelectBtn;

  const LeftMenu({required this.listSelectBtn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 73),
      color: Colors.white,
      width: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listSelectBtn.map((selectBtn) {
          return selectBtn.isSelected ? buttonSelected(selectBtn.index) : buttonSelect(selectBtn.index);
        }).toList(),
      ),
    );
  }

  Widget buttonSelect(int index) {
    return Container(
      width: 220,
      child: TextButton(
        child:  Align(
          alignment: Alignment.centerLeft,
          child: Text(listSelectBtn[index].text,
            style: TextStyle(color: Colors.black, fontSize: 18),),
        ),
        onPressed: () => appRouter.go(listSelectBtn[index].path, extra: {}),
        onHover: (value) {listSelectBtn[index].isSelected = value;},
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
          backgroundColor: MaterialStateProperty.all(listSelectBtn[index].isSelected ? Color.fromRGBO(242, 238, 242, 1) : Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonSelected(int index) {
    return Container(
      width: 220,
      child: TextButton(
        child:  Align(
          alignment: Alignment.centerLeft,
          child: Text(listSelectBtn[index].text,
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)
          ),
        ),
        onPressed: () => appRouter.go(listSelectBtn[index].path, extra: {}),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(242, 242, 242, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }
}