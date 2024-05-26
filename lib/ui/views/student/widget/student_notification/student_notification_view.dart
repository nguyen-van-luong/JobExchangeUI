import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/student_notification.dart';

import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../router.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/pagination.dart';
import '../../../../widgets/student_notification_item.dart';
import '../../../employer/widget/header_page.dart';
import '../../blocs/student_notification/student_notification_bloc.dart';

class StudentNotificationView extends StatefulWidget {
  const StudentNotificationView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<StatefulWidget> createState() => _StudentNotificationViewState();
}

class _StudentNotificationViewState extends State<StudentNotificationView> {
  late StudentNotificationBloc _bloc;
  late int page;
  final _readController = TextEditingController();
  final List<String> readStrs = ["Tất cả", "Chưa xem"];

  @override
  void initState() {
    _bloc = StudentNotificationBloc()
      ..add(LoadEvent(
          isRead: widget.params['isRead'] != null ? false : null,
          page: widget.params['page'] ?? "1"));
  }

  @override
  void didUpdateWidget(StudentNotificationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        isRead: widget.params['isRead'] != null ? false : null,
        page: widget.params['page'] ?? "1"));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    page = int.parse(widget.params['page'] ?? "1");
    String? read = widget.params['isRead'];
    if(read != null)
      _readController.text = 'Chưa xem';
    else
      _readController.text = 'Tất cả';
    return BlocProvider(
      create: (context) {
        return _bloc;
      },
      child: BlocBuilder<StudentNotificationBloc, StudentNotificationState>(
        builder: (context, state) {
          if(state is LoadSuccess) {
            List<StudentNotification> studentNotifications = state.result.resultList;
            if(state.message != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                state.message = null;
              });
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: headerPage("Thông báo")),
                Container(
                  width: 700,
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0),
                            child: textFieldCustom(
                                "Lọc trạng thái",
                                menuDropDown(readStrs, _readController,
                                        (read) {
                                      if(read == "Chưa xem") {
                                        appRouter.go('/student_notification/isRead=true&page=$page');
                                      } else {
                                        appRouter.go('/student_notification/page=$page');
                                      }
                                    })),
                          )
                        ],
                      ),
                      buildNotification(studentNotifications),
                      Pagination(
                        path: '/student_notification',
                        totalItem: state.result.count,
                        params: widget.params,
                        selectedPage: int.parse(widget.params['page'] ?? "1"),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (state is Message) {
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
    );
  }

  Widget buildNotification(List<StudentNotification> studentNotifications) {
    return Column(
      children: [
        for(int i = 0; i < studentNotifications.length; i++)
          StudentNotificationItem(studentNotification: studentNotifications[i]),
      ],
    );
  }
}