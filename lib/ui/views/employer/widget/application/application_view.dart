import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../models/application.dart';
import '../../../../common/utils/date_time.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../router.dart';
import '../../../../widgets/notification.dart';
import '../../../../widgets/pagination.dart';
import '../../blocs/application/application_bloc.dart';
import '../header_page.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<StatefulWidget> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  late ApplicationBloc _bloc;
  final _positionController = TextEditingController();
  final _statusController = TextEditingController();
  late int page;
  bool isCheckedAll = false;

  final List<String> status = ["Chưa xem", "Đã xem", "Đã liên lạc"];

  @override
  void initState() {
    _bloc = ApplicationBloc()
      ..add(LoadEvent(
          title: widget.params['title'] ?? null,
          status: widget.params['status'] ?? null,
          page: widget.params['page'] ?? "1"));
  }

  @override
  void didUpdateWidget(ApplicationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        title: widget.params['title'] ?? null,
        status: widget.params['status'] ?? null,
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
    _positionController.text = widget.params['title'] ?? "";
    _statusController.text = widget.params['status'] ?? "";
    return BlocProvider(
      create: (context) {
        _bloc.add(LoadEvent(
            title: widget.params['title'] ?? null,
            status: widget.params['status'] ?? null,
            page: widget.params['page'] ?? "1"));
        return _bloc;
      },
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          if(state is LoadSuccess) {
            List<Application> applications = state.result.resultList;
            if(state.message != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                state.message = null;
              });
            }
            return Column(
                children: [
                  headerPage("Hồ sơ ứng tuyển"),
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
                        for(int i = 0; i < applications.length; i++)
                          bulidRow(state, applications[i], state.isCheckeds, i),
                        Pagination(
                          path: '/application',
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
          Text("Lọc vị trí:", style: TextStyle(fontSize: 16.0)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8),
              height: 36,
              child: TextField(
                style: const TextStyle(
                    fontSize: 16.0, color: Colors.black),
                controller: _positionController,
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
            child: textFieldCustom("Lọc trạng thái", menuDropDown(status, _statusController)),
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
                  path: "/application",
                  titleJob: _positionController.text,
                  status: _statusController.text
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
              Text("Số lượng hồ sơ: ", style: TextStyle(fontSize: 16),),
              Text('${state.result.count}', style: TextStyle(fontSize: 24, color: Colors.redAccent),)
            ],
          ),
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
                    showTopRightSnackBar(context, "Vui lòng chọn hồ sơ để từ chối!", NotifyType.warning);
                  });
              },
              child: const Text("Từ chối",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  softWrap: false,
                  maxLines: 1),
            ),
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
          child: Text("Tên hồ sơ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        ),
        Expanded(
          flex: 10,
          child: Text("Vị trí ứng tuyển", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 5,
          child: Text("Thời gian nộp", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 5,
          child: Text("Trạng thái", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        )
      ],
    );
  }

  Widget bulidRow(LoadSuccess state, Application application, List<bool> isCheckeds, int index) {
    final _statusRowController = TextEditingController();
    _statusRowController.text = application.status;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => null,
                  child: Text(
                    application.cv.student.fullname,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.indigo[700]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                  child: InkWell(
                    onTap: () => null,
                    hoverColor: Colors.black12,
                    child: Text(
                      application.cv.positionWant,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: InkWell(
              onTap: () => appRouter.go("/job/${application.job.id}"),
              hoverColor: Colors.black12,
              child: Text(
                application.job.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                softWrap: true,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              getTimeAgo(application.createdAt),
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: menuDropDown(status, _statusRowController,
              (String? value) {
                _bloc.add(UpdateStatus(data: state, status: value, index: index));
              }
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

  String getSearchQuery({
    required path,
    required String titleJob,
    required String status}) {
    return path + "/title=$titleJob&status=$status";
  }
}