import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/views/student/blocs/follow/follow_bloc.dart';

import '../../../../../models/follow.dart';
import '../../../../widgets/header_view.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/pagination.dart';
import 'employer_feed_id.dart';

class FollowView extends StatefulWidget {
  const FollowView({required this.params});
  final Map<String, String> params;

  @override
  State<FollowView> createState() => _FollowViewState();
}

class _FollowViewState extends State<FollowView> {

  late FollowBloc _bloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          _bloc = FollowBloc();
          _bloc.add(LoadEvent(page: widget.params['page'] ?? '1'));
          return _bloc;
        },
        child: BlocBuilder<FollowBloc, FollowState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              if(state.message != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                  state.message = null;
                });
              }
              List<Follow> follows = state.result!.resultList;
              int size = follows.length;
              return Column(
                children: [
                  headerView("Dánh sách nhà tuyển dụng quan tâm"),
                  Container(
                      margin: EdgeInsets.all(40),
                      child:  Column(
                        children: [
                          for(int i = 0 ;i < size;i = i + 2)
                            buildItemEmployerRow(state, i, i + 1),
                          Pagination(
                            path: '/studentFollow',
                            totalItem: state.result!.count,
                            params: widget.params,
                            selectedPage: int.parse(widget.params['page'] ?? "1"),
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
        )
    );
  }

  Widget buildItemEmployerRow(LoadSuccess state, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: EmployerFeedItem(
            isFollow: state.follows[index1],
            employer: state.result!.resultList[index1].employer,
            callback: (isFollow) => _bloc.add(OnFollow(data: state, index: index1, isFollow: isFollow)),
          ),
        ),
        Expanded(
          child: index2 < state.result!.resultList.length ? EmployerFeedItem(
            isFollow: state.follows[index2],
            employer: state.result!.resultList[index2].employer,
            callback: (isFollow) => _bloc.add(OnFollow(data: state, index: index2, isFollow: isFollow)),
          ) : Container(),
        )
      ],
    );
  }
}