import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/dtos/bool_wrapper.dart';
import 'package:untitled1/models/StudentSkill.dart';
import 'package:untitled1/models/activity.dart';
import 'package:untitled1/models/education.dart';
import 'package:untitled1/models/experience.dart';
import 'package:untitled1/models/project.dart';
import 'package:untitled1/models/reference_person.dart';
import 'package:untitled1/repositories/student_skill_repository.dart';
import 'package:untitled1/ui/views/student/blocs/cv_cv/cu_cv_bloc.dart';
import 'package:untitled1/ui/views/student/widget/education/education_feed_item.dart';

import '../../../../../dtos/cv_dto.dart';
import '../../../../../models/certificate.dart';
import '../../../../../models/hobby.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/province.dart';
import '../../../../../models/skill.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../router.dart';
import '../../../../widgets/header_form.dart';
import '../../../../widgets/header_view.dart';
import '../../../../widgets/industry_drop_down.dart';
import '../../../../widgets/notification.dart';
import '../../../employer/widget/cu_job/industry_specialization_item.dart';
import '../activity/activity_feed_item.dart';
import '../activity/activity_create.dart';
import '../cerificate/cerificate_create.dart';
import '../cerificate/cerificate_feed_item.dart';
import '../education/education_create.dart';
import '../experience/experience_create.dart';
import '../experience/experience_feed_item.dart';
import '../hobby/hobby_create.dart';
import '../hobby/hobby_feed_item.dart';
import '../project/project_create.dart';
import '../project/project_feed_item.dart';
import '../reference_person/reference_person_create.dart';
import '../reference_person/reference_person_feed_item.dart';
import '../student_skill/student_skill_create.dart';
import '../student_skill/student_skill_feed_item.dart';

class CUCVView extends StatefulWidget {
  const CUCVView({super.key, required this.params});
  final Map<String, String> params;

  @override
  State<CUCVView> createState() => _CUCVViewState();
}

class _CUCVViewState extends State<CUCVView> {
  final _formKey = GlobalKey<FormState>();
  StudentSkillRepository studentSkillRepository = StudentSkillRepository();
  late CUCVBloc _bloc;
  int? id;

  final _fullnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _careerObjectiveController = TextEditingController();
  final _positionWantController = TextEditingController();
  final _yearOfExperienceController = TextEditingController();
  final _workingFormController = TextEditingController();
  final _salaryWantController = TextEditingController();
  final _emailController = TextEditingController();

  final List<String> experienceStrs = ["Chưa có kinh nghiệm", "Dưới 1 năm", "1 năm", "2 năm", "3 năm", "4 năm", "5 năm", "Trên 5 năm"];
  final List<String> workingForms = ["Toàn thời gian", "Bán thời gian", "Thực tập", "Khác"];
  final List<String> sexs = ["Nam", "Nữ"];

  List<StudentSkill> studentSkills = [];
  List<Industry> industries = [];
  List<Activity> activities = [];
  List<Education> educations = [];
  List<Certificate> certificates = [];
  List<Experience> experiences = [];
  List<Hobby> hobbies = [];
  List<Project> projects = [];
  List<ReferencePerson> referencePeople = [];

  Province? provinceSelected = null;
  Industry? industrySelected = null;
  String? sexSelected = null;
  String? validateIndustry = '';
  StudentSkill? studentSkillSelected = null;
  BoolWrapper showCreateActivity = BoolWrapper(false);
  BoolWrapper showCreateEducation = BoolWrapper(false);
  BoolWrapper showCreateCertificate = BoolWrapper(false);
  BoolWrapper showCreateExperience = BoolWrapper(false);
  BoolWrapper showCreateHobby = BoolWrapper(false);
  BoolWrapper showCreateProject = BoolWrapper(false);
  BoolWrapper showCreateReferencePerson = BoolWrapper(false);
  BoolWrapper showCreateSkill = BoolWrapper(false);


  @override
  void initState() {
    super.initState();
    _bloc = CUCVBloc()
      ..add(LoadEvent(
          id: int.tryParse(widget.params['id'] ?? '')
      ));
  }

  @override
  void didUpdateWidget(CUCVView oldWidget) {
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
      child: BlocListener<CUCVBloc, CUCVState>(
        listener: (context, state) {
          if(state is CuCVStateData) {
            if(state.cv != null) {
              _fullnameController.text = state.cv!.fullname;
              _birthdayController.text = DateFormat('yyyy-MM-dd').format(state.cv!.birthday);
              _addressController.text = state.cv!.address;
              _phoneNumberController.text = state.cv!.phoneNumber;
              _careerObjectiveController.text = state.cv!.careerObjective ?? '';
              _positionWantController.text = state.cv!.positionWant;
              sexSelected = convertSex(state.cv!.sex);
              _yearOfExperienceController.text = state.cv!.yearOfExperience?.toString() ?? '';
              _salaryWantController.text = state.cv!.salaryWant?.toString() ?? '';
              _workingFormController.text = state.cv!.workingForm ?? '';
              _emailController.text = state.cv!.email;
              studentSkills = state.cv!.studentSkills;
              industries = state.cv!.industries;
              activities = state.cv!.activities;
              educations = state.cv!.educations;
              certificates = state.cv!.certificates;
              experiences = state.cv!.experiences;
              hobbies = state.cv!.hobbies;
              projects = state.cv!.projects;
              referencePeople = state.cv!.referencePeople;
              provinceSelected = state.provinces.firstWhere((element) => element.name == state.cv!.province.name);
            }
          }
        },
        child: BlocBuilder<CUCVBloc, CUCVState>(
          builder: (context, state) {
            if(state is CuCVStateData) {
              if(state.message != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                  state.message = null;
                });
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    headerView(id == null ? "Tạo hồ sơ" : "Cập nhật hồ sơ",),
                    Container(
                        margin: EdgeInsets.all(40),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 40),
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 40,
                                        child: FilledButton(
                                          onPressed: () {
                                            bool check = checkList();
                                            if(_formKey.currentState!.validate() && check) {
                                              CVDto? cvDto= createJob(false);
                                              if(cvDto != null) {
                                                if(id == null)
                                                  _bloc.add(SaveEvent(cv: cvDto));
                                                else
                                                  _bloc.add(UpdateEvent(cv: cvDto, id: id!));
                                              }
                                            }
                                          },
                                          child: Text("Lưu",
                                              style: TextStyle(fontSize: 20),
                                              softWrap: false,
                                              maxLines: 1),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 16),
                                        child: FilledButton(
                                          onPressed: () {
                                            CVDto? cvDto= createJob(true);
                                            if(cvDto != null)
                                              _bloc.add(SaveEvent(cv: cvDto));
                                          },
                                          child: Text("Lưu tạm",
                                              style: TextStyle(fontSize: 20),
                                              softWrap: false,
                                              maxLines: 1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                buildIndividual(state.provinces),
                                buildCommon(),
                                buildIndustry(state.industries, industries),
                                buildEducation(state.educations, state.industries),
                                buildCertificate(state.certificates, certificates),
                                buildSkill(state.studentSkills, studentSkills, state.skills),
                                buildHobby(state.hobbies, hobbies),
                                buildActivity(state.activities, activities),
                                buildExperience(state.experiences, experiences),
                                buildProject(state.projects, projects),
                                buildReferencePerson(state.referencePeople, referencePeople)
                              ],
                            ),
                          ],
                        )
                    )
                  ],
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
        ),
      )
    );
  }

  Widget buildIndividual(List<Province> provinces) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          headerForm(lable: "Thông tin cá nhân"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Họ và tên", textFormField(_fullnameController, 'Nguyễn Văn A...', validator)),
                textFieldCustom("Ngày sinh", textFieldDate(context, _birthdayController, 'chọn', validator))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Tỉnh / thành phố",
                    Container(
                      width: 200,
                      child: proviceDropDownForm(provinces,
                          provinceSelected,
                          "Chọn",
                              (value) {
                            if(value == null)
                              return "Vui lòng chọn tỉnh / thành phố";
                            return null;
                          },
                              (Province? province) {provinceSelected = province;}),
                    )),
                textFieldCustom("Địa chỉ", textFormField(_addressController, 'Số nhà 20, phố Trung Hóa, phường Tam Quan Nam,huyện Hoài Nhơn', validator))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Giới tính",
                  Container(
                    width: 200,
                    child: menuDropDownForm(sexs,
                        sexSelected,
                        "Chọn",
                        (value) {
                          if(value == null)
                            return "Vui lòng chọn giới tính";
                          return null;
                        },
                        (sex) {
                          sexSelected = sex;
                        }),
                  )
                ),
                textFieldCustom("Số điện thoại", textFieldNumber(_phoneNumberController, validator))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Email", textFormField(_emailController, 'mmm@gmail.com', validator)),
                Container()
              ],
            ),
          ),
        ],
      ),
    );
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
                textFieldCustom("Vị trí mong muốn", textFormField(_positionWantController, 'Lập trình viên...', validator)),
                textFieldCustom("Số năm kinh nghiệm", menuDropDown(experienceStrs, _yearOfExperienceController)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Hình thức làm việc", menuDropDown(workingForms, _workingFormController)),
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Mức lương mong muốn"),
                      ),
                      textFieldNumber(_salaryWantController, (value) => null),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mục tiêu nghề nghiệp:"),
                  textForm(_careerObjectiveController)
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget buildEducation(List<Education> educationBases, List<Industry> industries) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Học vấn"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black38,
                        width: 2
                      )
                    )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in educations.asMap().entries)
                            buildEducationFeed(
                                item.value,
                                buildButtonRemove(item, educations)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in educationBases)
                          if(educations.any((element) => element.id == item.id))
                            Container()
                          else
                            buildEducationFeed(item, buildButtonAdd(item, educations)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo học vấn", "Thêm học vấn", showCreateEducation),
          SizedBox(height: 10),
          showCreateEducation.value ? EducationWidget(callback: (education) {
            setState(() {
              educations.insert(0, education);
              educationBases.add(education);
            });
          }, industries: industries,) : Container()
        ],
      ),
    );
  }

  Widget buildCertificate(List<Certificate> certificateBases, List<Certificate> certificates) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Chứng chỉ"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in certificates.asMap().entries)
                            buildCerificateFeed(
                                item.value,
                                buildButtonRemove(item, certificates)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in certificateBases)
                          if(certificates.any((element) => element.id == item.id))
                            Container()
                          else
                            buildCerificateFeed(item, buildButtonAdd(item, certificates)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo chứng chỉ", "Thêm chứng chỉ", showCreateCertificate),
          SizedBox(height: 10),
          showCreateCertificate.value ? CerificateWidget(callback: (certificate) {
            setState(() {
              certificates.insert(0, certificate);
              certificateBases.add(certificate);
            });
          }) : Container()
        ],
      ),
    );
  }

  Widget buildExperience(List<Experience> experienceBases, List<Experience> experiences) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Kinh nghiệm"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in experiences.asMap().entries)
                            buildExperienceFeed(
                                item.value,
                                buildButtonRemove(item, experiences)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in experienceBases)
                          if(experiences.any((element) => element.id == item.id))
                            Container()
                          else
                            buildExperienceFeed(item, buildButtonAdd(item, experiences)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo kinh nghiệm", "Thêm kinh nghiệm", showCreateExperience),
          SizedBox(height: 10),
          showCreateExperience.value ? ExperienceWidget(callback: (experience) {
            setState(() {
              experiences.insert(0, experience);
              experienceBases.add(experience);
            });
          }) : Container()
        ],
      ),
    );
  }

  Widget buildHobby(List<Hobby> hobbyBases, List<Hobby> hobbies) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Sở thích"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in hobbies.asMap().entries)
                            buildHobbyFeed(
                                item.value,
                                buildButtonRemove(item, hobbies)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in hobbyBases)
                          if(hobbies.any((element) => element.id == item.id))
                            Container()
                          else
                            buildHobbyFeed(item, buildButtonAdd(item, hobbies)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo sở thích", "Thêm sở thích", showCreateHobby),
          SizedBox(height: 10),
          showCreateHobby.value ? HobbyWidget(callback: (hobby) {
            setState(() {
              hobbies.insert(0, hobby);
              hobbyBases.add(hobby);
            });
          }) : Container()
        ],
      ),
    );
  }

  Widget buildProject(List<Project> projectBases, List<Project> projects) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Dự án"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in projects.asMap().entries)
                            buildProjectFeed(
                                item.value,
                                buildButtonRemove(item, projects)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in projectBases)
                          if(projects.any((element) => element.id == item.id))
                            Container()
                          else
                            buildProjectFeed(item, buildButtonAdd(item, projects)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo dự án", "Thêm dự án", showCreateProject),
          SizedBox(height: 10),
          showCreateProject.value ? ProjectWidget(callback: (project) {
            setState(() {
              projects.insert(0, project);
              projectBases.add(project);
            });
          }) : Container()
        ],
      ),
    );
  }

  Widget buildReferencePerson(List<ReferencePerson> referencePersonBases, List<ReferencePerson> referencePeople) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Người tham chiếu"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in referencePeople.asMap().entries)
                            buildReferencePersonFeed(
                                item.value,
                                buildButtonRemove(item, referencePeople)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in referencePersonBases)
                          if(referencePeople.any((element) => element.id == item.id))
                            Container()
                          else
                            buildReferencePersonFeed(item, buildButtonAdd(item, referencePeople)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo người tham chiếu", "Thêm người tham chiếu", showCreateReferencePerson),
          SizedBox(height: 10),
          showCreateReferencePerson.value ? ReferencePersonWidget(callback: (referencePerson) {
            setState(() {
              referencePeople.insert(0, referencePerson);
              referencePersonBases.add(referencePerson);
            });
          }) : Container()
        ],
      ),
    );
  }

  Widget buildActivity(List<Activity> activityBases, List<Activity> activities) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Hoạt động tham gia"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in activities.asMap().entries)
                            buildActivityFeed(
                                item.value,
                                buildButtonRemove(item, activities)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in activityBases)
                          if(activities.any((element) => element.id == item.id))
                            Container()
                          else
                            buildActivityFeed(item, buildButtonAdd(item, activities)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo hoạt động", "Thêm hoạt động", showCreateActivity),
          SizedBox(height: 10),
          showCreateActivity.value ? ActivityWidget(callback: (activity) {
            setState(() {
              activities.insert(0, activity);
              activityBases.add(activity);
            });
          },) : Container(),
        ],
      ),
    );
  }

  Widget showBtn(String lableTrue, String lableFalse, BoolWrapper isShow) {
    String text = isShow.value ? lableTrue : lableFalse;
    return TextButton(
      onPressed: () {
        setState(() {
          isShow.value = !isShow.value;
        });
      },
      child: Text('$text',
        style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
    );
  }

  IconButton buildButtonAdd(Object object, List<Object> objects) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          objects.add(object);
        });
      },
      iconSize: 20,
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.black54),
      )
    );
  }

  IconButton buildButtonRemove(var object, List<Object> objects) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        setState(() {
          objects.removeAt(object.key);
        });
      },
      iconSize: 20,
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.black54),
      )
    );
  }

  Widget buildSkill(List<StudentSkill> studentSkillBases, List<StudentSkill> studentSkills, List<Skill> skills) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerForm(lable: "Kỹ năng"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Colors.black38,
                              width: 2
                          )
                      )
                  ),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Danh sách đã chọn",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 10,),
                          for (var item in studentSkills.asMap().entries)
                            buildStudentSkillFeed(
                                item.value,
                                buildButtonRemove(item, skills)
                            )
                        ]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Danh sách chưa chọn",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10,),
                        for (var item in studentSkillBases)
                          if(studentSkills.any((element) => element.id == item.id))
                            Container()
                          else
                            buildStudentSkillFeed(item, buildButtonAdd(item, studentSkills)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          showBtn("Ẩn tạo kỹ năng", "Thêm kỹ năng", showCreateSkill),
          SizedBox(height: 10),
          showCreateSkill.value ? StudentSkillWidget(skills: skills,callback: (skill) {
            setState(() {
              studentSkills.insert(0, skill);
              studentSkillBases.add(skill);
            });
          }) : Container()
        ],
      ),
    );
  }

  Widget buildIndustry(List<Industry> industryBases, List<Industry> industries) {
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
                for (var item in industries.asMap().entries)
                  IndustryItem(
                    industry: item.value.name,
                    onDelete: () {
                      setState(() {
                        industries.removeAt(item.key);
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
                            industryBases,
                            industrySelected,
                            "Chọn",
                            (value) => null,
                            selectIndustry)),
                      )
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {
                      if(industrySelected != null) {
                        industries.add(industrySelected!);

                        setState(() {
                          validateIndustry = null;
                          industrySelected = null;
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

  Future<void> selectIndustry(Industry? industry) async {
    industrySelected = industry;
    setState(() {
    });
  }

  CVDto? createJob(bool isPrivate) {
    if(_formKey.currentState!.validate()) {
      return CVDto(fullname: _fullnameController.text,
          birthday: DateFormat('yyyy-MM-dd').parse(_birthdayController.text),
          address: _addressController.text,
          sex: getSex(),
          activities: activities.map((e) => e.id).toList(),
          referencePeople: referencePeople.map((e) => e.id).toList(),
          email: _emailController.text,
          projects: projects.map((e) => e.id).toList(),
          industries: industries.map((e) => e.id).toList(),
          phoneNumber: _phoneNumberController.text,
          experiences: experiences.map((e) => e.id).toList(),
          positionWant: _positionWantController.text,
          province: provinceSelected ?? Province.empty(),
          salaryWant: int.parse(_salaryWantController.text),
          studentSkills: studentSkills.map((e) => e.id).toList(),
          hobbies: hobbies.map((e) => e.id).toList(),
          workingForm: _workingFormController.text,
          certificates: certificates.map((e) => e.id).toList(),
          educations: educations.map((e) => e.id).toList(),
          avatar: null,
          careerObjective: _careerObjectiveController.text,
          yearOfExperience: _yearOfExperienceController.text,
          isPrivate: isPrivate
      );
    }
    return null;
  }

  String convertSex(bool? sex) {
    if(sex == null)
      return '';
    if(sex)
      return 'Nữ';
    return 'Nam';
  }

  bool? getSex() {
    if(sexSelected == 'Nam')
      return false;
    else if(sexSelected == 'Nữ')
      return true;
    return null;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập nội dung';
    }
    return null;
  }

  bool checkList() {
    if(industries.isNotEmpty) {
      return true;
    }

    setState(() {
      if(industries.isEmpty) {
        validateIndustry = 'Cần tạo ít nhất một ngành nghề!';
      }
    });

    return false;
  }
}