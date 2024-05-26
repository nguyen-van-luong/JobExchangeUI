import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/reference_person_dto.dart';
import 'package:untitled1/models/reference_person.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../repositories/reference_person_repository.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/notification.dart';

typedef FunctionCallback = Function(ReferencePerson referencePerson);

class ReferencePersonWidget extends StatefulWidget {
  final FunctionCallback callback;

  const ReferencePersonWidget({super.key, required this.callback});

  @override
  State<ReferencePersonWidget> createState() => _ReferencePersonWidgetState();
}

class _ReferencePersonWidgetState extends State<ReferencePersonWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameControler = TextEditingController();
  final _numberPhoneControler = TextEditingController();
  final _positionControler = TextEditingController();
  final _companyControler = TextEditingController();
  final referencePersonRepository = ReferencePersonRepository();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Tên", textFormField(_nameControler, 'Nguyễn Văn A...', validator)),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {onAdd();},
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
            SizedBox(height: 8,),
            textFieldCustom("Số điện thoại", textFieldNumber(_numberPhoneControler, validator)),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Công ty", textFormField(_companyControler, 'Công ty Abc...', validator)),
                ),
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Vị trí", textFormField(_positionControler, 'Lập trình viên...', validator)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      ReferencePersonDto referencePersonDto = ReferencePersonDto(
          studentId: JwtPayload.userId!,
          company: _companyControler.text,
          name: _nameControler.text,
          phoneNumber: _numberPhoneControler.text,
          position: _positionControler.text);
      Future<Response<dynamic>> future = referencePersonRepository.create(referencePersonDto: referencePersonDto);
      future.then((response) {
        widget.callback(ReferencePerson.fromJson(response.data));
        _companyControler.text = '';
        _nameControler.text = '';
        _positionControler.text = '';
        _numberPhoneControler.text = '';
      }).catchError((error) {
        String message = getMessageFromException(error);
        showTopRightSnackBar(
            context, message, NotifyType.error);
      });
    }
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập nội dung';
    }
    return null;
  }
}