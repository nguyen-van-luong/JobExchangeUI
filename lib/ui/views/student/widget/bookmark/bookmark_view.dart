import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/bookmark.dart';
import 'package:untitled1/ui/views/student/blocs/bookmark/bookmark_bloc.dart';
import 'package:untitled1/ui/views/student/widget/bookmark/job_feed_item.dart';

import '../../../../widgets/header_view.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/pagination.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({required this.params});
  final Map<String, String> params;

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  late BookmarkBloc _bloc;

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
          _bloc = BookmarkBloc();
          _bloc.add(LoadEvent(page: widget.params['page'] ?? '1'));
          return _bloc;
        },
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              if(state.message != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                  state.message = null;
                });
              }
              List<Bookmark> bookmarks = state.result!.resultList;
              int size = bookmarks.length;
              return Column(
                children: [
                  headerView("Dánh sách bài đăng quan tâm"),
                  Container(
                      margin: EdgeInsets.all(40),
                      child:  Column(
                        children: [
                          for(int i = 0 ;i < size;i = i + 2)
                            buildItemJobRow(state, i, i + 1),
                          Pagination(
                            path: '/studentBookmark',
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

  Widget buildItemJobRow(LoadSuccess state, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: JobFeedItem(
            isBookmark: state.bookmarks[index1],
            job: state.result!.resultList[index1].job,
            callback: (isBookmark) => _bloc.add(OnBookmark(data: state, index: index1, isBookmark: isBookmark)),
          ),
        ),
        Expanded(
          child: index2 < state.result!.resultList.length ? JobFeedItem(
            isBookmark: state.bookmarks[index2],
            job: state.result!.resultList[index2].job,
            callback: (isBookmark) => _bloc.add(OnBookmark(data: state, index: index2, isBookmark: isBookmark)),
          ) : Container(),
        )
      ],
    );
  }
}