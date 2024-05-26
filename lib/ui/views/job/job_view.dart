import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/province.dart';
import 'package:untitled1/ui/common/utils/widget.dart';
import 'package:untitled1/ui/views/job/bloc/job_bloc.dart';

import '../../../models/industry.dart';
import '../../../models/job.dart';
import '../../router.dart';
import '../../widgets/industry_drop_down.dart';
import '../../widgets/notification.dart';
import '../../widgets/pagination.dart';

class JobView extends StatefulWidget {

  const JobView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<StatefulWidget> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  late JobBloc _bloc;

  final searchController = TextEditingController();
  final _ageFromController = TextEditingController();
  final _ageToController = TextEditingController();
  final _salaryFromController = TextEditingController();
  final _salaryToController = TextEditingController();
  String? workingFormSelected = null;
  String? experienceSelected = null;
  String? degreeSelected = null;
  Province? provinceSelected = null;
  late int page;
  Industry? industrySelected = null;
  Industry? industryTem = null;
  late String? indsutryName;
  late String provinceName;

  final List<String> degrees = ["trống","Trên đại học", "Đại học", "Cao đẳng", "Trung cấp", "Trung học", "Chứng chỉ", "Không yêu cầu"];
  final List<String> experiences = ["trống","Chưa có kinh nghiệm", "Dưới 1 năm", "1 năm", "2 năm", "3 năm", "4 năm", "5 năm", "Trên 5 năm"];
  final List<String> workingForms = ["trống","Toàn thời gian", "Bán thời gian", "Thực tập", "Khác"];

  @override
  void initState() {
    super.initState();
    _bloc = JobBloc()
      ..add(LoadEvent(
        page: int.tryParse(widget.params['page'] ?? '1'),
        searchContent: widget.params['q'] ?? '',
        province: widget.params['province'],
        industry: widget.params['industry'],
        ageFrom: int.tryParse(widget.params['ageFrom'] ?? ''),
        ageTo: int.tryParse(widget.params['ageTo'] ?? ''),
        experience: widget.params['experience'],
        salaryFrom: int.tryParse(widget.params['salaryFrom'] ?? ''),
        salaryTo: int.tryParse(widget.params['salaryTo'] ?? ''),
        degree: widget.params['degree'],
        isPropose: bool.tryParse(widget.params['propose'] ?? 'false'),
        workingForm: widget.params['workingForm'],
      ));
  }

  @override
  void didUpdateWidget(JobView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        page: int.tryParse(widget.params['page'] ?? '1'),
        searchContent: widget.params['q'] ?? '',
        province: widget.params['province'],
        industry: widget.params['industry'],
        ageFrom: int.tryParse(widget.params['ageFrom'] ?? ''),
        ageTo: int.tryParse(widget.params['ageTo'] ?? ''),
        experience: widget.params['experience'],
        salaryFrom: int.tryParse(widget.params['salaryFrom'] ?? ''),
        salaryTo: int.tryParse(widget.params['salaryTo'] ?? ''),
        degree: widget.params['degree'],
        isPropose: bool.tryParse(widget.params['propose'] ?? 'false'),
        workingForm: widget.params['workingForm']
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
      child: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          } else if(state is LoadSuccess) {
            page = int.parse(widget.params['page'] ?? "1");
            searchController.text = widget.params['q'] ?? "";
            indsutryName = widget.params['industry'] ?? "";
            provinceName = widget.params['province'] ?? "";
            _ageFromController.text = widget.params['ageFrom'] ?? '';
            _ageToController.text = widget.params['ageTo'] ?? '';
            experienceSelected = widget.params['experience'];
            _salaryFromController.text = widget.params['salaryFrom'] ?? '';
            _salaryToController.text = widget.params['salaryTo'] ?? '';
            degreeSelected = widget.params['degree'];
            workingFormSelected = widget.params['workingForm'];
          }
        },
        child: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              try {
                industrySelected = state.industries.firstWhere((element) => element.name == indsutryName);
              } catch(e) {
                industrySelected = null;
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
                selectIndustry),
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
                    path: "/viewsearch",
                  searchStr: searchController.text,
                  industry: indsutryName,
                  province: provinceName,
                  ageFrom: _ageFromController.text,
                  ageTo: _ageToController.text,
                  experience: experienceSelected,
                  salaryFrom: _salaryFromController.text,
                  salaryTo: _salaryToController.text,
                  degree: degreeSelected,
                  workingForm: workingFormSelected,
                ));
              },
              child: const Text("Tìm kiếm",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  softWrap: false,
                  maxLines: 1),
            ),
          ),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(minWidth: 120),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,// Màu chữ của nút
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                appRouter.go('/viewsearch/propose=true');
              },
              child: const Text("Đề xuất",
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
    List<Job> jobs = state.result.resultList;

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 300,
              child: Column(
                children: [
                  Text("LỌC NÂNG CAO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  SizedBox(height: 16,),
                  buildFilter('Kinh nghiệm',
                      menuDropDownForm(
                        experiences,
                        experienceSelected,
                        'trống',
                        (value) => null,
                        (experience) { experienceSelected = experience;}
                      ),
                      null,
                  ),
                  SizedBox(height: 16,),
                  buildFilter('Mức lương',
                      Row(
                        children: [
                          textFieldNumber(_salaryFromController,(value) => null, 60),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text("~"),
                          ),
                          textFieldNumber(_salaryToController,(value) => null, 60),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Triệu"),
                          )
                        ],
                      ),
                      null,
                      200
                  ),
                  SizedBox(height: 16,),
                  buildFilter('Độ tuổi',
                      Row(
                        children: [
                          textFieldNumber(_ageFromController,(value) => null, 60),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text("~"),
                          ),
                          textFieldNumber(_ageToController,(value) => null, 60)
                        ],
                      ),
                      null
                  ),
                  SizedBox(height: 16,),
                  buildFilter('Trình độ',
                      menuDropDownForm(
                          degrees,
                          degreeSelected,
                          'trống',
                          (value) => null,
                          (degree) { degreeSelected = degree;}
                      ),
                      null
                  ),
                  SizedBox(height: 16,),
                  buildFilter('Hình thức làm việc',
                      menuDropDownForm(
                          workingForms,
                          workingFormSelected,
                          'trống',
                          (value) => null,
                          (workingForm) { workingFormSelected = workingForm;}
                      ),
                      null
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,// Màu chữ của nút
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          appRouter.go(getSearchQuery(
                            path: "/viewsearch",
                            searchStr: searchController.text,
                            industry: industrySelected == null ? "" : industrySelected!.name,
                            province: provinceName,
                            ageFrom: _ageFromController.text,
                            ageTo: _ageToController.text,
                            experience: experienceSelected,
                            salaryFrom: _salaryFromController.text,
                            salaryTo: _salaryToController.text,
                            degree: degreeSelected,
                            workingForm: workingFormSelected,
                          ));
                        },
                        child: const Text("Áp dụng",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            softWrap: false,
                            maxLines: 1),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent,// Màu chữ của nút
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          appRouter.go(getSearchQuery(
                              path: "/viewsearch",
                              searchStr: searchController.text,
                              industry: industrySelected == null ? "" : industrySelected!.name,
                              province: provinceName
                          ));
                        },
                        child: const Text("Hũy",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            softWrap: false,
                            maxLines: 1),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 20,),
            Expanded(child: Column(
              children: [
                for(int i = 0 ;i < jobs.length;i = i + 2)
                  buildItemJobRow(jobs[i], i + 1 < jobs.length ? jobs[i + 1] : null),
                Pagination(
                  path: '/viewsearch',
                  totalItem: state.result.count,
                  params: widget.params,
                  selectedPage: int.parse(widget.params['page'] ?? "1"),
                )
              ],
            ))
          ],
        )
    );
  }

  Widget buildFilter(String lable, Widget content, String? validate, [double width = 160]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 90,
              child: Text(lable, style: TextStyle(fontSize: 14),),
            ),
            SizedBox(width: 10,),
            SizedBox(width: width, child: content)
          ],
        ),
        validate == null ? Container() :
        Text(validate, style: TextStyle(fontSize: 12, color: Colors.red[900]),)
      ],
    );
  }

  Future<void> selectIndustry(Industry? industry) async {
    indsutryName = industry == null ? null : industry.name;

    setState(() {
    });
  }

  String getSearchQuery({
    required path,
    required String searchStr,
    required String? industry,
    required String? province,
    String? ageFrom,
    String? ageTo,
    String? experience,
    String? salaryFrom,
    String? salaryTo,
    String? degree,
    String? workingForm}) {
    String param = '';
    if(industry != null && industry.isNotEmpty && industry != 'trống') {
      param += '&industry=$industry';
    }
    if(province != null && province.isNotEmpty && province != 'trống') {
      param += '&province=$province';
    }
    if(ageFrom != null && ageFrom.isNotEmpty && ageFrom != 'trống') {
      param += '&ageFrom=$ageFrom';
    }
    if(ageTo != null && ageTo.isNotEmpty && ageTo != 'trống') {
      param += '&ageTo=$ageTo';
    }
    if(experience != null && experience.isNotEmpty && experience != 'trống') {
      param += '&experience=$experience';
    }
    if(salaryFrom != null && salaryFrom.isNotEmpty && salaryFrom != 'trống') {
      param += '&salaryFrom=$salaryFrom';
    }
    if(salaryTo != null && salaryTo.isNotEmpty && salaryTo != 'trống') {
      param += '&salaryTo=$salaryTo';
    }
    if(degree != null && degree.isNotEmpty && degree != 'trống') {
      param += '&degree=$degree';
    }
    if(workingForm != null && workingForm.isNotEmpty && workingForm != 'trống') {
      param += '&workingForm=$workingForm';
    }
    return path + "/q=$searchStr$param";
  }
}