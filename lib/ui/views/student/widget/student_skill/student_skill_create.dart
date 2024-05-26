import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/student_skill_dto.dart';
import 'package:untitled1/models/StudentSkill.dart';
import 'package:untitled1/models/skill.dart';

import '../../../../../dtos/jwt_payload.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../repositories/student_skill_repository.dart';
import '../../../../common/utils/message_from_exception.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/skill_dropdown.dart';

typedef FunctionCallback = Function(StudentSkill studentSkill);

class StudentSkillWidget extends StatefulWidget {
  final FunctionCallback callback;
  final List<Skill> skills;

  const StudentSkillWidget({super.key, required this.skills, required this.callback});

  @override
  State<StudentSkillWidget> createState() => _StudentSkillWidgetState();
}

class _StudentSkillWidgetState extends State<StudentSkillWidget> {
  final _formKey = GlobalKey<FormState>();
  final studentSkillRepository = StudentSkillRepository();
  Skill? skillSelect = null;
  String? levelSelected = null;

  List<String> levels = ['Sơ cấp', 'Trung cấp', 'Cao cấp'];

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
                Expanded(
                  child: textFieldCustom("Kỹ năng",
                    Container(
                      width: 200,
                      child: skillDropDown(
                          widget.skills,
                          skillSelect,
                          "Chọn",
                          (value) {
                            if(value == null)
                              return "Vui lòng chọn mức độ thành thạo";
                            return null;
                          },
                          (skill) {
                            skillSelect = skill;
                          }
                      ),
                    )),
                ),
                Expanded(
                  child: textFieldCustom("Mức độ thành tạo",
                      Container(
                        width: 200,
                        child: menuDropDownForm(
                            levels,
                            levelSelected,
                            "Chọn",
                            (value) {
                              if(value == null)
                                return "Vui lòng chọn mức độ thành thạo";
                              return null;
                            },
                            (level) {
                              levelSelected = level;
                            }),
                      )),
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
            )
          ],
        ),
      ),
    );
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      StudentSkillDto studentSkillDto = StudentSkillDto(skillId: skillSelect!.id, studentId: JwtPayload.userId!, level: levelSelected!);
      Future<Response<dynamic>> future = studentSkillRepository.create(skillDto: studentSkillDto);
      future.then((response) {
        widget.callback(StudentSkill.fromJson(response.data));
        skillSelect = null;
        levelSelected = null;
      }).catchError((error) {
        String message = getMessageFromException(error);
        showTopRightSnackBar(
            context, message, NotifyType.error);
      });
    }
  }
}