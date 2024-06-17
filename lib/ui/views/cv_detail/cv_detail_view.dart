import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/views/cv_detail/blocs/cv_detail_bloc.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/cv_body.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/menu_action.dart';

import '../../../dtos/jwt_payload.dart';
import '../../common/utils/date_time.dart';
import '../../widgets/notification.dart';
import '../../widgets/user_avatar.dart';

class CVDetailView extends StatefulWidget {
  const CVDetailView({super.key, required this.id});
  final String? id;

  @override
  State<CVDetailView> createState() => _CVDetailView();
}

class _CVDetailView extends State<CVDetailView> {
  late CVDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CVDetailBloc()
      ..add(LoadEvent(id: widget.id!));
  }

  @override
  void didUpdateWidget(CVDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(id: widget.id!));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<CVDetailBloc, CVDetailState>(
            listener: (context, state) {},
            child: BlocBuilder<CVDetailBloc, CVDetailState>(
              builder: (context, state) {
                if(state is LoadSuccess) {
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
                            cvBody(state.cv)
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
                  child: InkWell(
                    onTap: () => null,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: UserAvatar(
                          imageUrl: state.cv.student.avatarUrl,
                          size: 124,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => null,
                            child: Text(
                              state.cv.student.fullname,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.indigo[700]),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            getTimeAgo(state.cv.updatedAt),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 4),
                        child: Text(
                          state.cv.positionWant,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 4),
                        child: Row(
                          children: [
                            for(var industry in state.cv.industries)
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${industry.name}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                          ],
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
              child: (JwtPayload.role != "ROLE_student" || JwtPayload.userId != state.cv.student.id) ? Container() :
              Tooltip(
                message: "Hiển thị các hành động",
                child: MenuCVAction(id: state.cv.id),
              ),
            )
          ],
        )
    );
  }
}