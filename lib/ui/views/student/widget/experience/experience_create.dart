import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/experience_dto.dart';
import 'package:untitled1/models/experience.dart';
import 'package:untitled1/repositories/experience_repository.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../common/utils/function_util.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/notification.dart';

typedef FunctionCallback = Function(Experience experience);

class ExperienceWidget extends StatefulWidget {
  final FunctionCallback callback;

  const ExperienceWidget({super.key, required this.callback});

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  final _formKey = GlobalKey<FormState>();
  final _companyControler = TextEditingController();
  final _positionControler = TextEditingController();
  final _descripControler = TextEditingController();
  final timeStartControler = TextEditingController();
  final timeEndControler = TextEditingController();
  final experienceRepository = ExperienceRepository();

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
                  child: textFieldCustom("Công ty", textFormField(_companyControler, 'Công ty abc...', validator)),
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
            textFieldCustom("Vị trí", textFormField(_positionControler, 'Lập trình viên...', validator)),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: textFieldCustom('Thời gian bắt đầu',
                    textFormField(
                        timeStartControler,
                        '07/2020',
                        validateTime))),
                Expanded(child: textFieldCustom('Thời gian kết thúc',
                    textFormField(
                        timeEndControler,
                        '07/2024',
                        validateTimeEnd)))
              ],
            ),
            SizedBox(height: 8,),
            Text("Mô tả:"),
            textForm(_descripControler)
          ],
        ),
      ),
    );
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      ExperienceDto experienceDto = ExperienceDto(
          studentId: JwtPayload.userId!,
          company: _companyControler.text,
          period: "${timeStartControler.text} - ${timeEndControler.text}",
          position: _positionControler.text,
          description: _descripControler.text);
      Future<Response<dynamic>> future = experienceRepository.create(experienceDto: experienceDto);
      future.then((response) {
        widget.callback(Experience.fromJson(response.data));
        _companyControler.text = '';
        timeStartControler.text = '';
        timeEndControler.text = '';
        _positionControler.text = '';
        _descripControler.text = '';
      }).catchError((error) {
        String message = getMessageFromException(error);
        showTopRightSnackBar(
            context, message, NotifyType.error);
      });
    }
  }

  String? validateTimeEnd(String? value) {
    return validateTimeStartAndEnd(timeStartControler.text, value);
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập nội dung';
    }
    return null;
  }
}