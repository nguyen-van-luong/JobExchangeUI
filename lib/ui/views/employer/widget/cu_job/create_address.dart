import 'package:flutter/material.dart';
import 'package:untitled1/models/province.dart';
import 'package:untitled1/ui/common/utils/widget.dart';

import '../../../../common/utils/text_field_custom.dart';

class CreateAddress extends StatefulWidget {
  final List<Province> provinces;
  final Function(Province, String) onCreate;
  String? validateAddress;

  CreateAddress({super.key, required this.provinces, required this.onCreate, required this.validateAddress});

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final TextEditingController addressController = TextEditingController();
  Province? provinceSelected = null;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.validateAddress == null ? Container() :

        Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text("Tỉnh/Thành phố"),
                  ),
                  Container(
                    width: 200,
                    child: proviceDropDownForm(widget.provinces,
                        provinceSelected,
                        "Chọn",
                            (value) => null,
                            (Province? province) {provinceSelected = province;}),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: textFieldCustom("Chi tiết địa chỉ", textField(addressController)),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                onPressed: () {
                  if(provinceSelected != null && addressController.text.isNotEmpty) {
                    widget.onCreate(provinceSelected!, addressController.text);
                    setState(() {
                      provinceSelected = null;
                      addressController.text = '';
                      widget.validateAddress = null;
                    });
                  } else if(provinceSelected != null) {
                    widget.validateAddress = 'Vui lòng nhập chi tiết đại chỉ!';
                  } else {
                    widget.validateAddress = 'Vui lòng chọn tỉnh / thành phố!';
                  }
                },
                child: Text("Thêm", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        )
      ],
    );
  }
}
