import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ui/views/student_detail/blocs/student_detail_bloc.dart';
import 'package:untitled1/ui/views/student_detail/widgets/cv_view.dart';

import '../../common/utils/navigation.dart';
import '../../widgets/notification.dart';
import '../../widgets/user_avatar.dart';
import '../employer_detail/widgets/menu.dart';

class StudentDetailView extends StatefulWidget {
  const StudentDetailView({super.key, required this.id, required this.params});
  final String? id;
  final Map<String, String> params;

  @override
  State<StudentDetailView> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetailView> {

  late List<Navigation> listNavigation;

  late StudentDetailBloc _bloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    listNavigation = getNavigation;
    listNavigation[0].isSelected = true;

    return BlocProvider(
        create: (context) {
          _bloc = StudentDetailBloc();
          _bloc.add(LoadEvent(id: widget.id!, page: widget.params['page'] ?? '1'));
          return _bloc;
        },
        child: BlocBuilder<StudentDetailBloc, StudentDetailState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              if(state.message != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                  state.message = null;
                });
              }
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1280),
                  child: Container(
                    width: 1280,
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: Column(
                      children: [
                        header(state),
                        Container(
                          margin: EdgeInsets.only(top: 28),
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Menu(listSelectBtn: listNavigation),
                              buildCVs(state.result!, widget.params, widget.id ?? ""),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
        )
    );
  }

  Widget header(LoadSuccess state) {
    return Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: UserAvatar(
                    imageUrl: state.student.avatarUrl,
                    size: 124,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.student.fullname,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    child: Text(
                      state.student.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                  state.student.gender != null ? Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    child: buildSex(state.student.gender),
                  ) : Container(),
                  state.student.birthday != null ? Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    child: buildItemView(Icons.cake_outlined, DateFormat('dd/MM/yyyy').format(state.student.birthday!))
                  ) : Container(),
                  state.student.address != null ? Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: buildItemView(Icons.location_on_outlined, state.student.address ?? "")
                  ) : Container(),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget buildSex(bool? sex) {
    if(sex == null)
      return Container();
    if(sex)
      return buildItemView(Icons.female_outlined, "Nữ");
    return buildItemView(Icons.male_outlined, "Nam");
  }

  Widget buildItemView(IconData icon, String lable) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(lable,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }

  List<Navigation> get getNavigation => [
    Navigation(
      index: 0,
      text: "Hồ sơ",
      path: "/student/${widget.id}",
      widget: Container(),
    )
  ];
}