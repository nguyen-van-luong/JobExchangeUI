import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/certificate_dto.dart';
import 'package:untitled1/models/certificate.dart';
import 'package:untitled1/repositories/certificate_repository.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/notification.dart';

typedef FunctionCallback = Function(Certificate certificate);

class CerificateWidget extends StatefulWidget {
  final FunctionCallback callback;

  const CerificateWidget({super.key, required this.callback});

  @override
  State<CerificateWidget> createState() => _CerificateWidgetState();
}

class _CerificateWidgetState extends State<CerificateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameControler = TextEditingController();
  final cerificateRepository = CertificateRepository();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Tên chứng chỉ", textFormField(_nameControler, 'Ielts...', validator)),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {onAdd();},
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
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
      CertificateDto certificateDto = CertificateDto(studentId: JwtPayload.userId!, name: _nameControler.text);
      Future<Response<dynamic>> future = cerificateRepository.create(certificateDto: certificateDto);
      future.then((response) {
        widget.callback(Certificate.fromJson(response.data));
        _nameControler.text = '';
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