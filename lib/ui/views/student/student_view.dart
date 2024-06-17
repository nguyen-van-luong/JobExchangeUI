
import 'package:flutter/cupertino.dart';
import 'package:untitled1/ui/views/student/widget/bookmark/bookmark_view.dart';
import 'package:untitled1/ui/views/student/widget/cu_cv/cu_cv_view.dart';
import 'package:untitled1/ui/views/student/widget/cv_manage/cv_manage_view.dart';
import 'package:untitled1/ui/views/student/widget/follow/follow_view.dart';
import 'package:untitled1/ui/views/student/widget/student_manage/student_manage_view.dart';

import '../../common/utils/navigation.dart';
import '../employer/widget/left_menu.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key, this.indexSelected = 0, required this.params});

  final Map<String, String> params;
  final int indexSelected;

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
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
      path: "/student_manage",
      widget: StudentManageView(),
    ),
    Navigation(
      index: 1,
      text: "Tạo hồ sơ",
      path: "/cu_cv",
      widget: CUCVView(params: widget.params),
    ),
    Navigation(
      index: 2,
      text: "Quản lý hồ sơ",
      path: "/cv_manage",
      widget: CVManageView(params: widget.params),
    ),
    Navigation(
      index: 3,
      text: "Bài đăng quan tâm",
      path: "/studentBookmark",
      widget: BookmarkView(params: widget.params),
    ),
    Navigation(
      index: 4,
      text: "Theo dõi",
      path: "/studentFollow",
      widget: FollowView(params: widget.params,),
    ),
    Navigation(
      index: 5,
      text: "Thông báo",
      path: "/",
      widget: Container(),
    ),
  ];
}