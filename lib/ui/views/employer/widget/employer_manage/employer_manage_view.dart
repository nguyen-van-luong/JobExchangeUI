import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../widgets/add_image.dart';
import '../../../../widgets/header_form.dart';
import '../../../../widgets/header_view.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/user_avatar.dart';
import '../../blocs/employer_manage/employer_manage_bloc.dart';

class EmployerManageView extends StatefulWidget {
  const EmployerManageView();

  @override
  State<EmployerManageView> createState() => _EmployerManageViewState();
}

class _EmployerManageViewState extends State<EmployerManageView> {
  late EmployerManageBloc _bloc;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? sexSelected = null;

  String? avatarUrl = null;

  final List<String> sexs = ["Trống", "Nam", "Nữ"];

  @override
  void initState() {
    _bloc = EmployerManageBloc();
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
        child: BlocListener<EmployerManageBloc, EmployerManageState>(
          listener: (context, state) {
            if(state is LoadSuccess) {
              _nameController.text = state.employer.name;
              _descriptionController.text = state.employer.description ?? "";
              avatarUrl = state.employer.avatarUrl;
            }
          },
          child: BlocBuilder<EmployerManageBloc, EmployerManageState>(
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
                                        state.employer.avatarUrl = avatarUrl;
                                        state.employer.name = _nameController.text;
                                        state.employer.description = _descriptionController.text;
                                        _bloc.add(UpdateEvent(employer: state.employer));
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
                textFieldCustom("Tên", textFormField(_nameController, '', (value) => null)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                headerForm(lable: "Mô tả"),
                textForm(_descriptionController),
              ],
            ),
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