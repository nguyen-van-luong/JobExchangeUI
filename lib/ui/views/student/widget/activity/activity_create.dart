import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/activity_dto.dart';
import 'package:untitled1/repositories/activity_repository.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../models/activity.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/notification.dart';

typedef FunctionCallback = Function(Activity activity);

class ActivityWidget extends StatefulWidget {
  final FunctionCallback callback;

  const ActivityWidget({super.key, required this.callback});

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  final _formKey = GlobalKey<FormState>();
  final _activityNameControler = TextEditingController();
  final _activityPositionControler = TextEditingController();
  final _activityDescripControler = TextEditingController();
  final activityRepository = ActivityRepository();
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
                  child: textFieldCustom("Hoạt động", textFormField(_activityNameControler, 'Hiến máu...', validator)),
                ),
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Vị trí", textFormField(_activityPositionControler, 'Tình nguyện viên...', validator)),
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
            Text("Mô tả:"),
            textForm(_activityDescripControler)
          ],
        ),
      ),
    );
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      ActivityDto activityDto = ActivityDto(name: _activityNameControler.text,
        position: _activityPositionControler.text,
        description: _activityDescripControler.text,
        studentId: JwtPayload.userId!);
      Future<Response<dynamic>> future = activityRepository.create(activityDto: activityDto);
      future.then((response) {
        widget.callback(
            Activity.fromJson(response.data));
        _activityDescripControler.text = '';
        _activityPositionControler.text = '';
        _activityNameControler.text = '';
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

