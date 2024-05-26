import 'package:flutter/cupertino.dart';
import 'package:untitled1/ui/views/employer/widget/application/application_view.dart';
import 'package:untitled1/ui/views/employer/widget/cu_job/cu_job_view.dart';
import 'package:untitled1/ui/views/employer/widget/employer_notification/employer_notification_view.dart';
import 'package:untitled1/ui/views/employer/widget/job_manage/job_manage_view.dart';
import 'package:untitled1/ui/views/employer/widget/left_menu.dart';

import '../../common/utils/navigation.dart';

class EmployerView extends StatefulWidget {
  const EmployerView({super.key, this.indexSelected = 0, required this.params});

  final Map<String, String> params;
  final int indexSelected;

  @override
  _EmployerViewState createState() => _EmployerViewState();
}

class _EmployerViewState extends State<EmployerView> {
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
      text: "Tạo bài vết",
      path: "/cu_job",
      widget: CUJobView(params: widget.params),
    ),
    Navigation(
      index: 2,
      text: "Quản lý bài vết",
      path: "/job_manage",
      widget: JobManageView(params: widget.params,),
    ),
    Navigation(
      index: 3,
      text: "Hồ sơ ứng tuyển",
      path: "/application",
      widget: ApplicationView(params: widget.params),
    ),
    Navigation(
      index: 4,
      text: "Thông báo",
      path: "/employer_notification",
      widget: EmployerNotificationView(params: widget.params),
    ),
  ];
}