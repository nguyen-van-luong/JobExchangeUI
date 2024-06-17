import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/views/employer_detail/widgets/info_view.dart';
import 'package:untitled1/ui/views/employer_detail/widgets/job_view.dart';
import 'package:untitled1/ui/views/employer_detail/widgets/menu.dart';

import '../../../dtos/jwt_payload.dart';
import '../../../dtos/notify_type.dart';
import '../../common/utils/navigation.dart';
import '../../widgets/notification.dart';
import '../../widgets/user_avatar.dart';
import 'blocs/employer_detail_bloc.dart';

class EmployerDetailView extends StatefulWidget {
  const EmployerDetailView({super.key, required this.id, required this.params});
  final String? id;
  final Map<String, String> params;

  @override
  State<EmployerDetailView> createState() => _EmployerDetailState();
}

class _EmployerDetailState extends State<EmployerDetailView> {

  late List<Navigation> listNavigation;

  late EmployerDetailBloc _bloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    listNavigation = getNavigation;
    int indexSelected = 0;
    String? page = widget.params['page'] ?? '1';
    String description = widget.params['description'] ?? "";
    if(description == 'true') {
      indexSelected = 1;
      page = null;
    }
    listNavigation[indexSelected].isSelected = true;

    return BlocProvider(
      create: (context) {
        _bloc = EmployerDetailBloc();
        _bloc.add(LoadEvent(id: widget.id!, page: page));
        return _bloc;
      },
      child: BlocBuilder<EmployerDetailBloc, EmployerDetailState>(
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
                            SizedBox(height: 16,),
                            indexSelected == 1 ? buildInfo(state.employer.description ?? "") :
                              buildJobs(state.result!, widget.params, widget.id ?? ""),
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
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: UserAvatar(
                        imageUrl: state.employer.avatarUrl,
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
                        state.employer.name,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 4),
                        child: Text(
                          state.employer.email,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    side: BorderSide(color: state.isFollow ? Colors.redAccent : Colors.blueAccent, width: 3)
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  if (JwtPayload.role != "ROLE_student")
                    return showTopRightSnackBar(context, "Cần đăng nhập tài khoản sinh viên", NotifyType.info);
                  _bloc.add(FollowEvent(data: state, isFollow:  !state.isFollow));
                },
                child: state.isFollow ? Text('Hũy theo dõi', style: TextStyle(fontSize: 16)) :
                Text('Theo dõi', style: TextStyle(fontSize: 16),),
              ),
            )
          ],
        )
    );
  }

  List<Navigation> get getNavigation => [
    Navigation(
      index: 0,
      text: "Bài đăng",
      path: "/employer/${widget.id}",
      widget: Container(),
    ),
    Navigation(
      index: 1,
      text: "Thông tin",
      path: "/employer/${widget.id}/description=true",
      widget: Container(),
    )
  ];
}