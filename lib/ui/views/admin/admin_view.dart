import 'package:flutter/cupertino.dart';
import 'package:untitled1/ui/views/admin/widgets/industry_manage/industry_manage_view.dart';
import 'package:untitled1/ui/views/employer/widget/application/application_view.dart';
import 'package:untitled1/ui/views/employer/widget/cu_job/cu_job_view.dart';
import 'package:untitled1/ui/views/employer/widget/job_manage/job_manage_view.dart';
import 'package:untitled1/ui/views/employer/widget/left_menu.dart';

import '../../common/utils/navigation.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key, this.indexSelected = 0, required this.params});

  final Map<String, String> params;
  final int indexSelected;

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  late List<Navigation> listNavigation;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listNavigation = getNavigation;
    listNavigation[widget.indexSelected].isSelected = true;
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeftMenu(listSelectBtn: listNavigation),
          Expanded(
            child: listNavigation[widget.indexSelected].widget,
          ),
        ],
      ),
    );
  }

  List<Navigation> get getNavigation => [
    Navigation(
      index: 0,
      text: "Tài khoản",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 1,
      text: "Quản lý ngành nghề",
      path: "/industry_manage",
      widget: IndustryManageView(params: widget.params),
    ),
    Navigation(
      index: 2,
      text: "Quản lý kỹ năng",
      path: "/job_manage",
      widget: Container(),
    ),
    Navigation(
      index: 3,
      text: "Quản lý tỉnh / thành phố",
      path: "/application",
      widget: Container(),
    ),
  ];
}