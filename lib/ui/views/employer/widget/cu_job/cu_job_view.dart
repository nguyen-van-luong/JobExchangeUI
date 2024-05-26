import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/dtos/job_dto.dart';
import 'package:untitled1/ui/views/employer/blocs/cu_job/cu_job_bloc.dart';
import 'package:untitled1/ui/views/employer/widget/cu_job/address_item.dart';
import 'package:untitled1/ui/views/employer/widget/cu_job/industry_specialization_item.dart';
import 'package:untitled1/ui/views/employer/widget/cu_job/required_skill_item.dart';
import 'package:untitled1/ui/widgets/skill_dropdown.dart';

import '../../../../../models/address.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/province.dart';
import '../../../../../models/skill.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../router.dart';
import '../../../../widgets/form_view_custom.dart';
import '../../../../widgets/header_form.dart';
import '../../../../widgets/industry_drop_down.dart';
import '../../../../widgets/notification.dart';

class CUJobView extends StatefulWidget {
  const CUJobView({super.key, required this.params});
  final Map<String, String> params;

  @override
  State<CUJobView> createState() => _CUJobViewState();
}

class _CUJobViewState extends State<CUJobView> {

  final _formKey = GlobalKey<FormState>();
  int? id;
  late CUJobBloc _bloc;

  final _titleController = TextEditingController();
  final _duationController = TextEditingController();
  final _ageFromController = TextEditingController();
  final _ageToController = TextEditingController();
  final _salaryFromController = TextEditingController();
  final _salaryToController = TextEditingController();
  final _sexController = TextEditingController();
  final _quantityController = TextEditingController();
  final _degreeController = TextEditingController();
  final _workingFormController = TextEditingController();
  final _experienceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementController = TextEditingController();
  final _rightsController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final List<String> degrees = ["Trên đại học", "Đại học", "Cao đẳng", "Trung cấp", "Trung học", "Chứng chỉ", "Không yêu cầu"];
  final List<String> experiences = ["Chưa có kinh nghiệm", "Dưới 1 năm", "1 năm", "2 năm", "3 năm", "4 năm", "5 năm", "Trên 5 năm"];
  final List<String> workingForms = ["Toàn thời gian", "Bán thời gian", "Thực tập", "Khác"];
  final List<String> sexs = ["Trống", "Nam", "Nữ"];

  List<Province> provinces = [];
  List<Industry> industries = [];
  List<Industry> jobIndustries = [];
  List<Address> addresses = [];
  List<Skill> skills = [];
  List<Skill> jobSkills = [];
  Industry? industrySelected = null;
  Skill? skillSelected = null;
  String? validateSkill = '';
  String? validateAddress = '';
  String? validateIndustry = '';
  Province? provinceSelected = null;

  @override
  void initState() {
    super.initState();
    _bloc = CUJobBloc();
  }

  @override
  void didUpdateWidget(CUJobView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        id: int.tryParse(widget.params['id'] ?? '')
    ));
  }

  @override
  Widget build(BuildContext context) {
    id = int.tryParse(widget.params['id'] ?? '');
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<CUJobBloc, CUJobState>(
        listener: (context, state) {
          if(state is CuJobStateData) {
            if(state.job != null) {
              _titleController.text = state.job!.title;
              _duationController.text = DateFormat('yyyy-MM-dd').format(state.job!.duration);
              _ageFromController.text = state.job!.ageFrom?.toString() ?? '';
              _ageToController.text = state.job!.ageTo?.toString() ?? '';
              _salaryFromController.text = state.job!.salaryFrom?.toString() ?? '';
              _salaryToController.text = state.job!.salaryTo?.toString() ?? '';
              _sexController.text = convertSex(state.job!.sex);
              _quantityController.text = state.job!.quantity?.toString() ?? '';
              _degreeController.text = state.job!.degree ?? '';
              _workingFormController.text = state.job!.workingForm;
              _experienceController.text = state.job!.experience;
              _descriptionController.text = state.job!.description;
              _requirementController.text = state.job!.requirement;
              _rightsController.text = state.job!.rights;
              addresses = state.job!.addresses;
              jobIndustries = state.job!.industries;
              jobSkills = state.job!.skills;
            }
            provinces = state.provinces;
            industries = state.industries;
            skills = state.skills;
          } else if (state is SaveSuccess) {
            appRouter.go('/job/${state.jobId}');
          }
        },
        child: BlocBuilder<CUJobBloc, CUJobState>(
          builder: (context, state) {
            if(state is CuJobStateData) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      color: Colors.white,
                      child: Text(
                        id == null ? "Tạo bài viết" : "Cập nhật bài viết",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 600,
                                  child: TextFormField(
                                    validator: (value){
                                      if(value == null || value.isEmpty) {
                                        return "Vui lòng nhập tiêu đề!";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.black),
                                    controller: _titleController,
                                    decoration: const InputDecoration(
                                      labelText: 'Tiêu đề',
                                      labelStyle: const TextStyle(
                                          color: Color(0xff888888),
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.all(16),
                                      child: FilledButton(
                                        onPressed: () {
                                          bool check = checkList();
                                          if(_formKey.currentState!.validate() && check) {
                                            JobDto jobDto = createJob(false);
                                            if(id == null)
                                              _bloc.add(SaveEvent(job: jobDto));
                                            else
                                              _bloc.add(UpdateEvent(job: jobDto, id: id!));
                                          }
                                        },
                                        child: Text("Lưu",
                                            style: TextStyle(fontSize: 20),
                                            softWrap: false,
                                            maxLines: 1),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.all(16),
                                      child: FilledButton(
                                        onPressed: () {
                                          bool check = checkList();
                                          if(_formKey.currentState!.validate() && check) {
                                            JobDto jobDto = createJob(true);
                                            if(id == null)
                                              _bloc.add(SaveEvent(job: jobDto));
                                            else
                                              _bloc.add(UpdateEvent(job: jobDto, id: id!));
                                          }
                                        },
                                        child: Text("Lưu tạm",
                                            style: TextStyle(fontSize: 20),
                                            softWrap: false,
                                            maxLines: 1),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          buildCommon(),
                          buildAddress(),
                          buildIndustry(),
                          buildRequiredSkill(),
                          buildFormView("Mô tả", _descriptionController),
                          buildFormView("Yêu cầu", _requirementController),
                          buildFormView("Quyền lợi", _rightsController)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PostFailure) {
              showTopRightSnackBar(context, state.message, state.notifyType);
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

  Future<void> selectIndustry(Industry? industry) async {
    industrySelected = industry;
    setState(() {

    });
  }

  Widget buildCommon() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          headerForm(lable: "Thông tin chung"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Hạn nộp hồ sơ"),
                      ),
                      textFieldDate(context, _duationController, "chọn", validator)
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Độ tuổi"),
                      ),
                      textFieldNumber(_ageFromController,(value) => null),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text("~"),
                      ),
                      textFieldNumber(_ageToController,(value) => null)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Kinh nghiệm", menuDropDown(experiences, _experienceController)),
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Mức lương"),
                      ),
                      textFieldNumber(_salaryFromController,(value) => null),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text("~"),
                      ),
                      textFieldNumber(_salaryToController,(value) => null),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Triệu"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Giớ tính", menuDropDown(sexs, _sexController)),
                textFieldCustom("Bằng cấp", menuDropDown(degrees, _degreeController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Số lượng tuyển", textFieldNumber(_quantityController,(value) => null)),
                textFieldCustom("Hình thức làm việc", menuDropDown(workingForms, _workingFormController)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildRequiredSkill() {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerForm(lable: 'Kỹ năng cần có'),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (var skill in jobSkills.asMap().entries)
                  SkillItem(
                    skillName: skill.value.name,
                    onDelete: () {
                      setState(() {
                        jobSkills.removeAt(skill.key);
                      });
                    },
                  ),
              ],
            ),
            validateSkill == null ? Container() :
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(validateSkill!, style: TextStyle(color: Colors.red[900], fontSize: 12),),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            padding: const EdgeInsets.only(right: 10),
                            child: Text("Kỹ năng"),
                          ),
                          Expanded(
                            child: skillDropDown
                              (
                                skills,
                                skillSelected,
                                'Chọn',
                                (p0) => null,
                                (skill) {
                                  skillSelected = skill;
                                }
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {
                      if(skillSelected != null) {
                        setState(() {
                          jobSkills.add(skillSelected!);
                          skillSelected = null;
                          validateSkill = null;
                        });
                      } else {
                        setState(() {
                          validateSkill = 'Vui lòng chọn kỹ năng';
                        });
                      }
                    },
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  Widget buildAddress() {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerForm(lable: "Địa chỉ"),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (var address in addresses.asMap().entries)
                  AddressItem(
                    provinceName: address.value.province.name,
                    address: address.value.address,
                    onDelete: () {
                      setState(() {
                        addresses.removeAt(address.key);
                      });
                    },
                  ),
              ],
            ),
            validateAddress == null ? Container() :
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(validateAddress!, style: TextStyle(color: Colors.red[900], fontSize: 12),),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text("Tỉnh/Thành phố"),
                      ),
                      Container(
                        width: 200,
                        child: proviceDropDownForm(provinces,
                            provinceSelected,
                            "Chọn",
                                (value) => null,
                                (Province? province) {provinceSelected = province;}),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: textFieldCustom("Chi tiết địa chỉ", textField(addressController)),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {
                      if(provinceSelected != null && addressController.text.isNotEmpty) {
                        setState(() {
                          addresses.add(Address(province: provinceSelected!, address: addressController.text));
                          provinceSelected = null;
                          addressController.text = '';
                          validateAddress = null;
                        });
                      } else if(provinceSelected != null) {
                        setState(() {
                          validateAddress = 'Vui lòng nhập chi tiết đại chỉ!';
                        });
                      } else {
                        setState(() {
                          validateAddress = 'Vui lòng chọn tỉnh / thành phố!';
                        });
                      }
                    },
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  Widget buildIndustry() {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerForm(lable: "Lĩnh vực"),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (var item in jobIndustries.asMap().entries)
                  IndustryItem(
                    industry: item.value.name,
                    onDelete: () {
                      setState(() {
                        jobIndustries.removeAt(item.key);
                      });
                    },
                  ),
              ],
            ),
            validateIndustry == null ? Container() :
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(validateIndustry!, style: TextStyle(color: Colors.red[900], fontSize: 12),),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Ngành",
                    Container(
                        width: 200,
                        child: industryDropDown(
                            industries,
                            industrySelected,
                            "Chọn",
                            (value) => null,
                            selectIndustry)),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {
                      if(industrySelected != null) {
                        jobIndustries.add(industrySelected!);
                        setState(() {
                          industrySelected = null;
                          validateIndustry = null;
                        });
                      } else {
                        setState(() {
                          validateIndustry = 'Vui long chọn ngành!';
                        });
                      }
                    },
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  bool checkList() {
    if(addresses.isNotEmpty && jobIndustries.isNotEmpty) {
      return true;
    }

    setState(() {
      if(addresses.isEmpty) {
        validateAddress = 'Cần tạo ít nhất một địa chỉ!';
      }
      if(jobIndustries.isEmpty) {
        validateIndustry = 'Cần tạo ít nhất một ngành nghề!';
      }
    });

    return false;
  }

  JobDto createJob(bool isPrivate) {
    return JobDto(title: _titleController.text,
        duration: DateFormat('yyyy-MM-dd').parse(_duationController.text),
        ageFrom: checkValue(_ageFromController.text) ? null : int.parse(_ageFromController.text),
        ageTo: checkValue(_ageToController.text) ? null : int.parse(_ageToController.text),
        experience: _experienceController.text,
        sex: getSex(),
        salaryFrom: checkValue(_salaryFromController.text) ? null : int.parse(_salaryFromController.text),
        salaryTo: checkValue(_salaryToController.text) ? null : int.parse(_salaryToController.text),
        degree: checkValue(_degreeController.text) ? null : _degreeController.text,
        quantity: checkValue(_quantityController.text) ? null : int.parse(_quantityController.text),
        workingForm: _workingFormController.text,
        skills: jobSkills.map((e) => e.id).toList(),
        addresses: addresses,
        industries: jobIndustries.map((e) => e.id).toList(),
        description: _descriptionController.text,
        requirement: _requirementController.text,
        rights: _rightsController.text,
        isPrivate: isPrivate
    );
  }

  bool checkValue(String? text) {
    if (text == null || text.isEmpty)
      return true;
    return false;
  }

  String convertSex(bool? sex) {
    if(sex == null)
      return '';
    if(sex)
      return 'Nữ';
    return 'Nam';
  }

  bool? getSex() {
    if(_sexController.text == 'Nam')
      return false;
    else if(_sexController.text == 'Nữ')
      return true;
    return null;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập nội dung';
    }
    return null;
  }
}
