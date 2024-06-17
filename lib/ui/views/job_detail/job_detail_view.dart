import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/dtos/jwt_payload.dart';
import 'package:untitled1/dtos/notify_type.dart';
import 'package:untitled1/models/address.dart';
import 'package:untitled1/models/job.dart';
import 'package:untitled1/ui/views/job_detail/blocs/job_detail_bloc.dart';
import 'package:untitled1/ui/views/job_detail/widgets/menu_action.dart';

import '../../../models/cv.dart';
import '../../common/utils/date_time.dart';
import '../../router.dart';
import '../../widgets/notification.dart';
import '../../widgets/user_avatar.dart';

class JobDetailView extends StatefulWidget {
  const JobDetailView({super.key, required this.id});
  final String? id;

  @override
  State<JobDetailView> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetailView> {

  late JobDetailBloc _bloc;
  List<String> provinceStrs = [];

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
        _bloc = JobDetailBloc();
        _bloc.add(LoadEvent(id: widget.id!));
        return _bloc;
      },
      child: BlocListener<JobDetailBloc, JobDetailState>(
        listener: (context, state) {
        },
        child: BlocBuilder<JobDetailBloc, JobDetailState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              if(state.message != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message!.message, state.message!.notifyType);
                  state.message = null;
                });
              }
              for(Address address in state.job.addresses) {
                if(!provinceStrs.contains(address.province.name)) {
                  provinceStrs.add(address.province.name);
                }
              }

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
                        body(state.job)
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
                    onTap: state.job.employer.name == "" ? null :
                        () => appRouter.go("/employer/${state.job.employer.id}"),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: UserAvatar(
                          imageUrl: state.job.employer.avatarUrl,
                          size: 124,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: state.job.employer.name == "" ? null :
                                  () => appRouter.go("/employer/${state.job.employer.id}"),
                              child: Text(
                                state.job.employer.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.indigo[700]),
                                softWrap: true,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              getTimeAgo(state.job.updatedAt),
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
                            state.job.title,
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
                              for(String str in provinceStrs)
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    str,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2, bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_sharp,
                                size: 20,
                                color: Colors.grey[700],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2, right: 2),
                                child: Text("Hạn nộp hồ sơ:",
                                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                              ),
                              Text(DateFormat('dd/MM/yyyy').format(state.job.duration),
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2, bottom: 4),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 86, 143),  // This is the button color
                            ),
                            onPressed: () {
                              if (JwtPayload.role != "ROLE_student")
                                return showTopRightSnackBar(context, "Cần đăng nhập tài khoản sinh viên", NotifyType.info);
                              int comparison = state.job.duration.compareTo(DateTime.now());
                              if (comparison < 0)
                                showTopRightSnackBar(context, "Đã hết hạn nộp hồ sơ", NotifyType.info);
                              else
                                _showMyDialog(context, state);
                            },
                            child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("Nộp hồ sơ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24
                                  ),)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 40,)
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Column(
                children: [
                  (JwtPayload.role != "ROLE_employer" || JwtPayload.userId != state.job.employer.id) ? Container() :
                    Tooltip(
                      message: "Hiển thị các hành động",
                      child: MenuAction(id: state.job.id),
                    ),
                  SizedBox(height: 4,),
                  Tooltip(
                    message: "Bookmark",
                    child: IconButton(
                      icon: Icon(
                        Icons.bookmark, // Mã Unicode của biểu tượng con mắt
                        color: state.isBookmark ? Colors.blueAccent : Color.fromARGB(255, 212, 211, 211),
                        size: 32,
                      ),
                      onPressed: () {
                        if (JwtPayload.role != "ROLE_student")
                          return showTopRightSnackBar(context, "Cần đăng nhập tài khoản sinh viên", NotifyType.info);
                        _bloc.add(BookmarkEvent(data: state,isBookmark:  !state.isBookmark));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget body(Job job) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textHeader("Thông tin chung"),
                  Wrap(
                    children: [
                      commonItem(Icons.timer_sharp, "Hạn nộp hồ sơ", DateFormat('dd/MM/yyyy').format(job.duration)),
                      buildAge(job.ageFrom, job.ageTo),
                      commonItem(Icons.work_outline, "Kinh nghiệm", job.experience),
                      commonItem(Icons.attach_money, "Mức lương", "${job.salaryFrom} - ${job.salaryTo} triệu"),
                      buildSex(job.sex),
                      job.degree != null ?commonItem(Icons.school_outlined, "Bằng cấp", job.degree!):Container(),
                      job.quantity != null ? commonItem(Icons.group_outlined, "Số lượng tuyển", "${job.quantity}"):Container(),
                      commonItem(Icons.business_outlined, "Hình thức làm việc", job.workingForm),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textHeader("Ngành nghề"),
                  Wrap(
                    children: [
                      for(var industry in job.industries)
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
                ],
              )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Kỹ năng cần có"),
                    Wrap(
                      children: [
                        for(var skill in job.skills)
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${skill.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Địa chỉ"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(var address in job.addresses)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              "${address.province.name}: ${address.address}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Mô tả"),
                    Text(job.description, style: TextStyle(fontSize: 16),)
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Yêu cầu"),
                    Text(job.requirement, style: TextStyle(fontSize: 16))
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Quyền lợi"),
                    Text(job.rights, style: TextStyle(fontSize: 16))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  Widget textHeader(String lable) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Text(lable,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
    );
  }

  Widget buildAge(int? ageFrom, int? ageTo) {
    String text = "";
    if(ageFrom == null && ageTo == null)
      return Container();
    if(ageFrom != null && ageTo == null)
      text = "Từ $ageFrom tuổi trở lên";
    else if(ageFrom == null)
      text = "Dưới $ageTo tuổi";
    else
      text = "Từ $ageFrom đến $ageTo tuổi";
    return commonItem(Icons.cake_outlined, "Độ tuổi", text);
  }

  Widget buildSex(bool? sex) {
    if(sex == null)
      return Container();
    if(sex)
      return commonItem(Icons.female_outlined, "Giới tính", "Nữ");
    return commonItem(Icons.male_outlined, "Giới tính", "Nam");
  }

  Widget commonItem(IconData icon, String lable, String value) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.blueAccent
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lable,
                style: TextStyle(color: Colors.grey[700],),
              ),
              Text(value,
                style: TextStyle(fontSize: 16),
              )
            ],
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content:  SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(state.job.employer.name),
                    Text(state.job.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 4),
                      child: Text("Hồ sơ ứng tuyển:"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 600,
                      padding: EdgeInsets.only(bottom: 10),
                      child: buildCVApplication(state.cvApplications, setState),
                    ),
                    Container(height: 1,width: 600, color: Colors.blueAccent,),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Danh sách hồ sơ"),
                          TextButton(
                              onPressed: (){
                                appRouter.go("/cu_cv");
                              },
                              child: Text("Thêm hồ sơ", style: TextStyle(color: Colors.indigoAccent), )
                          )
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 300,
                      ),
                      child: Column(
                        children: [
                          for(CV cv in state.cvs)
                            if(state.cvApplications.any((element) => element.id == cv.id))
                              Container()
                            else
                              buildCV(cv, buildButtonChoose(cv, state.cvApplications, setState)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 86, 143),  // This is the button color
                  ),
                  onPressed: () {
                    _bloc.add(ApplicationEvent(data: state));
                    Navigator.of(context).pop();},
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
      },
    );
  }

  Widget buildCVApplication(List<CV> cvApplications, StateSetter setState) {
    if(cvApplications == null || cvApplications.isEmpty)
      return Text("Vui long chọn hồ sơ để ứng tuyên",
        style: TextStyle(color: Colors.black45),);
    return Column(
      children: [
        for(var cv in cvApplications.asMap().entries)
          buildCV(cv.value, buildButtonRemove(cv, cvApplications, setState)),
      ],
    );
  }

  Widget buildCV(CV cv, TextButton button) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 450),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => null,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: UserAvatar(
                        imageUrl: cv.student!.avatarUrl,
                        size: 40,
                      )),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () => null,
                                child: Text(
                                  cv.student.fullname,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.indigo[700]),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                getTimeAgo(cv.updatedAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 4),
                        child: InkWell(
                          onTap: () => null,
                          hoverColor: Colors.black12,
                          child: Text(
                            cv.positionWant,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            width: 100,
            child: button,
          )
        ],
      ),
    );
  }

  TextButton buildButtonChoose(CV cv, List<CV> cvApplications, StateSetter setState) {
    return TextButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
      onPressed: () {
        setState(() {
          cvApplications.insert(0, cv);
        });
      },
      child: Text("Chọn", style: TextStyle(color: Colors.white),),
    );
  }

  TextButton buildButtonRemove(var cv, List<CV> cvApplications, StateSetter setState) {
    return TextButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent) ),
      onPressed: () {
        setState(() {
          cvApplications.removeAt(cv.key);
        });
      },
      child: Text("Hủy", style: TextStyle(color: Colors.white),),
    );
  }
}
