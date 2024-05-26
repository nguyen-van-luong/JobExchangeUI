import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/project_dto.dart';
import 'package:untitled1/models/project.dart';
import 'package:untitled1/repositories/project_repository.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/notification.dart';

typedef FunctionCallback = Function(Project project);

class ProjectWidget extends StatefulWidget {
  final FunctionCallback callback;

  const ProjectWidget({super.key, required this.callback});

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  final _formKey = GlobalKey<FormState>();
  final _companyControler = TextEditingController();
  final _projectNameControler = TextEditingController();
  final _descripControler = TextEditingController();
  final projectRepository = ProjectRepository();

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
                  child: textFieldCustom("Công ty / nơi thực hiện", textFormField(_companyControler, 'Công ty abc...', validator)),
                ),
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Dự án", textFormField(_projectNameControler, 'Hệ thống...', validator)),
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
            textForm(_descripControler)
          ],
        ),
      ),
    );
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      ProjectDto projectDto = ProjectDto(
          studentId: JwtPayload.userId!,
          company: _companyControler.text,
          projectName: _projectNameControler.text,
          description: _descripControler.text);
      Future<Response<dynamic>> future = projectRepository.create(projectDto: projectDto);
      future.then((response) {
        widget.callback(Project.fromJson(response.data));
        _companyControler.text = '';
        _projectNameControler.text = '';
        _descripControler.text = '';
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