import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/views/students/bloc/students_bloc.dart';

import '../../../models/industry.dart';
import '../../../models/province.dart';
import '../../../models/student.dart';
import '../../common/utils/widget.dart';
import '../../router.dart';
import '../../widgets/industry_drop_down.dart';
import '../../widgets/notification.dart';
import '../../widgets/pagination.dart';
import '../../widgets/student_feed_item.dart';

class StudentsView extends StatefulWidget {

  const StudentsView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<StatefulWidget> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  late StudentsBloc _bloc;
  late int page;
  Province? provinceSelected = null;
  Industry? industrySelected = null;
  Industry? industryTem = null;
  late String? indsutryName;
  late String provinceName;

  @override
  void initState() {
    super.initState();
    _bloc = StudentsBloc()
      ..add(LoadEvent(
        page: int.tryParse(widget.params['page'] ?? '1'),
        province: widget.params['province'],
        industry: widget.params['industry'],
      ));
  }

  @override
  void didUpdateWidget(StudentsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        page: int.tryParse(widget.params['page'] ?? '1'),
      province: widget.params['province'],
      industry: widget.params['industry'],
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
      child: BlocListener<StudentsBloc, StudentsState>(
        listener: (context, state) {
          if (state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          } else if(state is LoadSuccess) {
            page = int.parse(widget.params['page'] ?? "1");
            indsutryName = widget.params['industry'] ?? "";
            provinceName = widget.params['province'] ?? "";
          }
        },
        child: BlocBuilder<StudentsBloc, StudentsState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              try {
                industrySelected = state.industries.firstWhere((element) => element.name == indsutryName);
              } catch(e) {
                industrySelected = null;
              }
              try {
                provinceSelected = state.provinces.firstWhere((element) => element.name == provinceName);
              } catch(e) {
                provinceSelected = null;
              }

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 40),
                width: 200,
                child: proviceDropDownForm(
                    state.provinces,
                    provinceSelected,
                    "Lọc theo tỉnh/thành phố",
                        (value) => null,
                        (province) {provinceSelected = province;}
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40),
                width: 200,
                child: industryDropDown(
                    state.industries,
                      industrySelected,
                    "Lọc theo ngành",
                    (value) => null,
                    (industry) {industrySelected = industry;}),
              ),
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
                backgroundColor: Colors.blue,// Màu chữ của nút
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                appRouter.go(getSearchQuery(
                  path: "/search_student",
                  industry: industrySelected == null ? '' : industrySelected!.name,
                  province: provinceSelected == null ? '' : provinceSelected!.name
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
    List<Student> students = state.result.resultList;

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            for(int i = 0 ;i < students.length;i = i + 2)
              buildItemStudentRow(state, i, i + 1),
            Pagination(
              path: '/search_student',
              totalItem: state.result.count,
              params: widget.params,
              selectedPage: int.parse(widget.params['page'] ?? "1"),
            )
          ],
        )
    );
  }

  Widget buildItemStudentRow(LoadSuccess state, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: StudentFeedItem(
            student: state.result!.resultList[index1]
          ),
        ),
        Expanded(
          child: index2 < state.result!.resultList.length ? StudentFeedItem(
            student: state.result!.resultList[index2],
          ) : Container(),
        )
      ],
    );
  }

  String getSearchQuery({
    required path,
    required String industry,
    required String province}) {
    if (industry == "Trống")
      industry = '';
    if (province == "Trống")
      province = '';
    return path + "/industry=$industry&province=$province";
  }
}