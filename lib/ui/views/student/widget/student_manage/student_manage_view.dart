import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ui/views/student/blocs/student_manage/student_manage_bloc.dart';

import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/add_image.dart';
import '../../../../widgets/header_view.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/user_avatar.dart';

class StudentManageView extends StatefulWidget {
  const StudentManageView();

  @override
  State<StudentManageView> createState() => _StudentManageViewState();
}

class _StudentManageViewState extends State<StudentManageView> {
  late StudentManageBloc _bloc;
  final _fullnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? sexSelected = null;

  String? avatarUrl = null;

  final List<String> sexs = ["Trống", "Nam", "Nữ"];

  @override
  void initState() {
    _bloc = StudentManageBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          _bloc.add(LoadEvent());
          return _bloc;
        },
        child: BlocListener<StudentManageBloc, StudentManageState>(
          listener: (context, state) {
            if(state is LoadSuccess) {
              _fullnameController.text = state.student.fullname;
              _phoneNumberController.text = state.student.phoneNumber ?? '';
              _addressController.text = state.student.address ?? '';
              _birthdayController.text = state.student.birthday != null
                  ? DateFormat("yyyy-MM-dd").format(state.student.birthday!)
                  : '';
              if(state.student.gender == null)
                sexSelected = 'Trống';
              else if (state.student.gender!) {
                sexSelected = 'Nữ';
              } else {
                sexSelected = 'Nam';
              }
              avatarUrl = state.student.avatarUrl;
            }
          },
          child: BlocBuilder<StudentManageBloc, StudentManageState>(
            builder: (context, state) {
              if(state is LoadSuccess) {
                if(state.message != null)
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                    state.message = null;
                  });

                return Column(
                  children: [
                    headerView("Tài khoản"),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(40),
                        child:  Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              padding: EdgeInsets.all(30),
                              child: IntrinsicWidth(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(width: 1, color: Colors.black38)
                                          )
                                      ),
                                      child: buildAvata(),
                                    ),
                                    buildInfo()
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              right: 30,
                              child: Column(
                                children: [
                                  Tooltip(
                                    message: "Lưu thông tin",
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue,// Màu chữ của nút
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      onPressed: () {
                                        state.student.avatarUrl = avatarUrl;
                                        state.student.fullname = _fullnameController.text;
                                        state.student.phoneNumber = _phoneNumberController.text == '' ? null : _phoneNumberController.text;
                                        state.student.address = _addressController.text == '' ? null : _addressController.text;
                                        state.student.birthday = _birthdayController.text =='' ? null : DateFormat('yyyy-MM-dd').parse(_birthdayController.text);
                                        if(sexSelected == 'Trống')
                                          state.student.gender = null;
                                        else if (sexSelected == 'Nữ') {
                                          state.student.gender = true;
                                        } else {
                                          state.student.gender = false;
                                        }
                                        _bloc.add(UpdateEvent(student: state.student));
                                      },
                                      child: const Text("Lưu",
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                          softWrap: false,
                                          maxLines: 1),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    )
                  ],
                );
              } else if (state is Message) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message, state.notifyType);
                });
                return Container(
                  alignment: Alignment.center,
                  child:
                  Text(state.message, style: const TextStyle(fontSize: 16)),
                );
              }

              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            },
          ),
        )
    );
  }

  Widget buildAvata() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ảnh đại diện", style: TextStyle(fontSize: 20),),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserAvatar(
              imageUrl: avatarUrl,
              size: 120,
            ),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddImage(imageCallback: upload),
                Text("Định dạng .jpg .jpeg .png dung lượng thấy hơn 300 KB", style: TextStyle(fontSize: 14, color: Colors.black38),)
              ],
            )
          ],
        )
      ],
    );
  }

  Widget buildInfo() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Họ và tên", textFormField(_fullnameController, '', (value) => null)),
                textFieldCustom("Ngày sinh", textFieldDate(context, _birthdayController, 'chọn', (value) => null))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Địa chỉ", textFormField(_addressController, '', (value) => null)),
                textFieldCustom("Giới tính",
                    Container(
                      width: 200,
                      child: menuDropDownForm(sexs,
                          sexSelected,
                          "Chọn",
                              (value) {
                            if(value == null)
                              return "Vui lòng chọn giới tính";
                            return null;
                          },
                              (sex) {
                            sexSelected = sex;
                          }),
                    )
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFieldCustom("Số điện thoại", textFieldNumber(_phoneNumberController, (value) => null))
                ],
              )
          ),
        ],
      ),
    );
  }

  void upload(String input) {
    setState(() {
      avatarUrl = input;
    });
  }
}