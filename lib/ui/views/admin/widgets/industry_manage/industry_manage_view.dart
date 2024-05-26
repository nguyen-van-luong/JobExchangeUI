import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/industry.dart';
import 'package:untitled1/ui/views/admin/blocs/industry_manage/industry_manage_bloc.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../common/utils/date_time.dart';
import '../../../../router.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/pagination.dart';
import '../../../employer/widget/header_page.dart';

class IndustryManageView extends StatefulWidget {
  const IndustryManageView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<StatefulWidget> createState() => _IndustryManageViewState();
}

class _IndustryManageViewState extends State<IndustryManageView> {
  late IndustryManageBloc _bloc;
  final _nameController = TextEditingController();
  late int page;
  bool isCheckedAll = false;

  final List<String> status = ["Chưa xem", "Đã xem", "Đã liên lạc"];

  @override
  void initState() {
    _bloc = IndustryManageBloc();
  }

  @override
  void didUpdateWidget(IndustryManageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        name: widget.params['name'] ?? '',
        page: widget.params['page'] ?? "1"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    page = int.parse(widget.params['page'] ?? "1");
    _nameController.text = widget.params['name'] ?? "";
    return BlocProvider(
      create: (context) {
        _bloc.add(LoadEvent(
            name: widget.params['name'] ?? '',
            page: widget.params['page'] ?? "1"));
        return _bloc;
      },
      child: BlocBuilder<IndustryManageBloc, IndustryManageState>(
        builder: (context, state) {
          if(state is LoadSuccess) {
            List<Industry> industries = state.result.resultList;
            if(state.message != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                state.message = null;
              });
            }
            return Column(
              children: [
                headerPage("Quản lý ngành nghề"),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      buildSearch(),
                      SizedBox(height: 16,),
                      buildAction(state),
                      headerTable(state.isCheckeds),
                      for(int i = 0; i < industries.length; i++)
                        bulidRow(state, industries[i], state.isCheckeds, i),
                      Pagination(
                        path: '/industry_manage',
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

  Widget buildSearch() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26, width: 2.0),
          )
      ),
      child: Row(
        children: [
          Text("Lọc tỉnh / thành phố:", style: TextStyle(fontSize: 16.0)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8),
              height: 36,
              child: TextField(
                style: const TextStyle(
                    fontSize: 16.0, color: Colors.black),
                controller: _nameController,
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
                    path: "/industry_manage",
                    name: _nameController.text
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

  Widget buildAction(LoadSuccess state) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Số lượng tỉnh / thành phố: ", style: TextStyle(fontSize: 16),),
              Text('${state.result.count}', style: TextStyle(fontSize: 24, color: Colors.redAccent),)
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 40),
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(minWidth: 120),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,// Màu chữ của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    if(state.isCheckeds.any((element) => element))
                      _showMyDialog(context, state);
                    else
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showTopRightSnackBar(context, "Vui lòng chọn tỉnh / thành phố cần xóa!", NotifyType.warning);
                      });
                  },
                  child: const Text("Xóa",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      softWrap: false,
                      maxLines: 1),
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
                    backgroundColor: Colors.green,// Màu chữ của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    // if(state.isCheckeds.any((element) => element))
                    //   _showMyDialog(context, state);
                    // else
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     showTopRightSnackBar(context, "Vui lòng chọn tỉnh / thành phố cần xóa!", NotifyType.warning);
                    //   });
                  },
                  child: const Text("Thêm",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      softWrap: false,
                      maxLines: 1),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget headerTable(List<bool> isCheckeds) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Checkbox(
            value: isCheckedAll,
            onChanged: (bool? value) {
              setState(() {
                isCheckedAll = value ?? false;
                for(int i = 0 ; i < isCheckeds.length; i++)
                  isCheckeds[i] = value ?? false;
              });
            },
          ),
        ),
        Expanded(
          flex: 10,
          child: Text("Lĩnh vực", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        ),
        Expanded(
          flex: 10,
          child: Text("Cập nhật", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 5,
          child: Container()
        )
      ],
    );
  }

  Widget bulidRow(LoadSuccess state, Industry industry, List<bool> isCheckeds, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Checkbox(
              value: isCheckeds[index],
              onChanged: (bool? value) {
                setState(() {
                  isCheckeds[index] = value ?? false;
                  int tem = 0;
                  for(int i = 0 ; i < isCheckeds.length; i++) {
                    if(!isCheckeds[i]) {
                      isCheckedAll = false;
                      return;
                    }
                  }
                  isCheckedAll = true;
                });
              },
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.only(top: 2, bottom: 4),
              child: InkWell(
                onTap: () => null,
                hoverColor: Colors.black12,
                child: Text(
                  industry.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                  softWrap: true,
                ),
              ),
            )
          ),
          Expanded(
            flex: 10,
            child: Text(
              getTimeAgo(industry.updatedAt ?? DateTime.now()),
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.greenAccent,// Màu chữ của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    // appRouter.go('/cu_job/id=${job.id}');
                  },
                  child: const Text("Chỉnh sửa",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      softWrap: false,
                      maxLines: 1),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, LoadSuccess state) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Xác nhận từ chối hồ sơ"),
          content:  Container(
            width: 400,
            child: SingleChildScrollView(
              child: const ListBody(
                children: <Widget>[
                  Text("Bạn có muốn từ chối các hồ sơ mà bạn đã chọn không?",
                    style: TextStyle(fontSize: 24),),
                  Text("Sau khi xác nhận, các hồ sơ sẽ bị loại khỏi danh sách!",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 86, 143),  // This is the button color
              ),
              onPressed: () {
                _bloc.add(DeleteEvent(data: state, params: widget.params));
                Navigator.pop(context);
              },
              child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Xác nhận",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),)
              ),

            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddDialog(BuildContext context, LoadSuccess state) async {
    TextEditingController nameNewController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Thêm ngành nghề"),
          content:  Container(
            width: 800,
            child: SingleChildScrollView(
              child: const ListBody(
                children: <Widget>[
                  Text("Bạn có muốn từ chối các hồ sơ mà bạn đã chọn không?",
                    style: TextStyle(fontSize: 24),),
                  Text("Sau khi xác nhận, các hồ sơ sẽ bị loại khỏi danh sách!",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 86, 143),  // This is the button color
              ),
              onPressed: () {
                _bloc.add(DeleteEvent(data: state, params: widget.params));
                Navigator.pop(context);
              },
              child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Xác nhận",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),)
              ),

            ),
          ],
        );
      },
    );
  }

  String getSearchQuery({
    required path,
    required String name}) {
    return path + "/name=$name";
  }
}