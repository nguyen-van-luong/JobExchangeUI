import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/employer.dart';
import 'package:untitled1/ui/views/employers/bloc/employers_bloc.dart';

import '../../router.dart';
import '../../widgets/employer_feed_item.dart';
import '../../widgets/notification.dart';
import '../../widgets/pagination.dart';

class EmployersView extends StatefulWidget {

  const EmployersView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<StatefulWidget> createState() => _EmployersViewState();
}

class _EmployersViewState extends State<EmployersView> {
  late EmployersBloc _bloc;
  late int page;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = EmployersBloc()
      ..add(LoadEvent(
        page: int.tryParse(widget.params['page'] ?? '1'),
        searchContent: widget.params['q'] ?? '',
      ));
  }

  @override
  void didUpdateWidget(EmployersView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        page: int.tryParse(widget.params['page'] ?? '1'),
        searchContent: widget.params['q'] ?? ''
    ));
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
      child: BlocListener<EmployersBloc, EmployersState>(
        listener: (context, state) {
          if (state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          } else if(state is LoadSuccess) {
            page = int.parse(widget.params['page'] ?? "1");
            searchController.text = widget.params['q'] ?? "";
          }
        },
        child: BlocBuilder<EmployersBloc, EmployersState>(
          builder: (context, state) {
            if(state is LoadSuccess) {

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1280),
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: Column(
                      children: [
                        buildSearch(state),
                        buildContent(state)
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is LoadFailure) {
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
      ),
    );
  }

  Widget buildSearch(LoadSuccess state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                style: const TextStyle(
                    fontSize: 16.0, color: Colors.black),
                controller: searchController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    hintText: 'Nhập từ khóa tìm kiếm...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(4)))),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(minWidth: 120),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,// Màu chữ của nút
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                appRouter.go(getSearchQuery(
                  path: "/search_employer",
                  searchStr: searchController.text,
                ));
              },
              child: const Text("Tìm kiếm",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  softWrap: false,
                  maxLines: 1),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent(LoadSuccess state) {
    List<Employer> employers = state.result.resultList;

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            for(int i = 0 ;i < employers.length;i = i + 2)
              buildItemEmployerRow(state, i, i + 1),
            Pagination(
              path: '/search_employer',
              totalItem: state.result.count,
              params: widget.params,
              selectedPage: int.parse(widget.params['page'] ?? "1"),
            )
          ],
        )
    );
  }

  Widget buildItemEmployerRow(LoadSuccess state, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: EmployerFeedItem(
              employer: state.result!.resultList[index1]
          ),
        ),
        Expanded(
          child: index2 < state.result!.resultList.length ? EmployerFeedItem(
            employer: state.result!.resultList[index2],
          ) : Container(),
        )
      ],
    );
  }

  String getSearchQuery({
    required path,
    required String searchStr}) {
    return path + "/q=$searchStr";
  }
}