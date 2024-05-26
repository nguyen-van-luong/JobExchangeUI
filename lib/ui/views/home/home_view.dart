import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/employer.dart';
import 'package:untitled1/ui/router.dart';
import 'package:untitled1/ui/views/home/bloc/home_bloc.dart';

import '../../../models/cv.dart';
import '../../../models/job.dart';
import '../../../models/student.dart';
import '../../widgets/cv_feed_item.dart';
import '../../widgets/employer_feed_item.dart';
import '../../widgets/job_feed_item.dart';
import '../../widgets/notification.dart';
import '../../widgets/student_feed_item.dart';

class HomeView extends StatefulWidget {

  const HomeView();

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc()
      ..add(LoadEvent());
  }

  @override
  void didUpdateWidget(HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
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
                        buildContent("Việc làm đề xuất", '/viewsearch', buildJob(state.jobs)),
                        SizedBox(width: 10,),
                        buildContent("Hồ sơ đề xuất", '/cv/viewsearch', buildCV(state.cvs)),
                        // SizedBox(width: 10,),
                        // buildContent("Nhà tuyển dụng", '/search_employer', buildEmployer(state.employers)),
                        // SizedBox(width: 10,),
                        // buildContent("Sinh viên", '/search_student', buildStudent(state.students))
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

  Widget buildContent(String header, String url, Widget body) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(header, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            InkWell(
              onTap: () {appRouter.go(url);},
              child: Text("Xem thêm", style: TextStyle(color: Colors.blueAccent, fontSize: 16),),
            )
          ],
        ),
        body
      ],
    );
  }

  Widget buildJob(List<Job> jobs) {
    return Column(
      children: [
        for(int i = 0 ;i < jobs.length;i = i + 2)
          buildItemJobRow(jobs, i, i + 1),
      ],
    );
  }

  Widget buildCV(List<CV> cvs) {
    return Column(
      children: [
        for(int i = 0 ;i < cvs.length;i = i + 2)
          buildItemCVRow(cvs, i, i + 1),
      ],
    );
  }

  Widget buildEmployer(List<Employer> employers) {
    return Column(
      children: [
        for(int i = 0 ;i < employers.length;i = i + 2)
          buildItemEmployerRow(employers, i, i + 1),
      ],
    );
  }

  Widget buildStudent(List<Student> students) {
    return Column(
      children: [
        for(int i = 0 ;i < students.length;i = i + 2)
          buildItemStudentRow(students, i, i + 1),
      ],
    );
  }

  Widget buildItemJobRow(List<Job> jobs, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: JobFeedItem(
              job: jobs[index1]
          ),
        ),
        Expanded(
          child: index2 < jobs.length ? JobFeedItem(
            job: jobs[index2],
          ) : Container(),
        )
      ],
    );
  }

  Widget buildItemCVRow(List<CV> cvs, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: CVFeedItem(
              cv: cvs[index1]
          ),
        ),
        Expanded(
          child: index2 < cvs.length ? CVFeedItem(
            cv: cvs[index2],
          ) : Container(),
        )
      ],
    );
  }

  Widget buildItemEmployerRow(List<Employer> employers, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: EmployerFeedItem(
              employer: employers[index1]
          ),
        ),
        Expanded(
          child: index2 < employers.length ? EmployerFeedItem(
            employer: employers[index2],
          ) : Container(),
        )
      ],
    );
  }

  Widget buildItemStudentRow(List<Student> students, int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: StudentFeedItem(
              student: students[index1]
          ),
        ),
        Expanded(
          child: index2 < students.length ? StudentFeedItem(
            student: students[index2],
          ) : Container(),
        )
      ],
    );
  }
}

