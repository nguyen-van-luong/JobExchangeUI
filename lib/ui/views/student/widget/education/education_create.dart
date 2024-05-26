import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/education_dto.dart';
import 'package:untitled1/models/education.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../models/industry.dart';
import '../../../../../repositories/education_repository.dart';
import '../../../../common/utils/function_util.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/industry_drop_down.dart';
import '../../../../widgets/notification.dart';

typedef FunctionCallback = Function(Education education);

class EducationWidget extends StatefulWidget {
  final FunctionCallback callback;
  final List<Industry> industries;

  const EducationWidget({super.key, required this.callback, required this.industries});

  @override
  State<EducationWidget> createState() => _EducationWidgetState();
}

class _EducationWidgetState extends State<EducationWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameSchoolControler = TextEditingController();
  final _classificationPositionControler = TextEditingController();
  final _scoreDescripControler = TextEditingController();
  final timeStartControler = TextEditingController();
  final timeEndControler = TextEditingController();
  final educationRepository = EducationRepository();
  Industry? industrySelected = null;

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
                textFieldCustom("Tên Trường", textFormField(_nameSchoolControler, 'Đại học Quy Nhơn...', validator)),
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
            Row(
              children: [
                Expanded(
                  child: textFieldCustom("Ngành",
                      Container(
                        width: 200,
                        child: industryDropDown(
                            widget.industries,
                            industrySelected,
                            "Chọn",
                            (value) {
                              if(value == null)
                                return "Vui lòng chọn ngành";
                              return null;
                            },
                            selectIndustry)),
                      )
                ),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: textFieldCustom("Điểm trung bình", textFormField(_scoreDescripControler, '3.7/4.0', validator)),
                ),
                Expanded(
                  child: textFieldCustom("Xếp loại", textFormField(_classificationPositionControler, 'Giỏi', validator)),
                )
              ],
            ),
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
            )
          ],
        ),
      ),
    );
  }



  void onAdd() {
    if (_formKey.currentState!.validate()) {
      EducationDto education = EducationDto(
          studentId: JwtPayload.userId!,
          nameSchool: _nameSchoolControler.text,
          industry: industrySelected!,
          period: "${timeStartControler.text} - ${timeEndControler.text}",
          score: _scoreDescripControler.text,
          classification: _classificationPositionControler.text);
      Future<Response<dynamic>> future = educationRepository.create(educationDto: education);
      future.then((response) {
        widget.callback(Education.fromJson(response.data));
        industrySelected = null;
        _nameSchoolControler.text = '';
        timeStartControler.text = '';
        timeEndControler.text = '';
        _scoreDescripControler.text = '';
        _classificationPositionControler.text = '';
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

  Future<void> selectIndustry(Industry? industry) async {
    industrySelected = industry;
    setState(() {

    });
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập nội dung';
    }
    return null;
  }
}

