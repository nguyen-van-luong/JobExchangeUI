import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/activity_view.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/experience_view.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/project_view.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/reference_person_view.dart';
import 'package:untitled1/ui/views/cv_detail/widgets/skill_view.dart';

import '../../../../models/cv.dart';
import 'education_view.dart';

Widget cvBody(CV cv) {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildLeft(cv),
          Expanded(child: buildRight(cv))
        ],
      ),
    ),
  );
}

Widget buildLeft(CV cv) {
  return Container(
    constraints: BoxConstraints(maxWidth: 400),
    padding: EdgeInsets.all(20),
    color: Color.fromARGB(255, 125, 202, 240),
    child: IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildForm(
              buildHeader('THÔNG TIN LIÊN HỆ', Icons.info_outline),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSex(cv.sex),
                  infoItem(Icons.cake_outlined, DateFormat('dd/MM/yyyy').format(cv.birthday)),
                  infoItem(Icons.email_outlined, cv.email),
                  infoItem(Icons.phone_android_outlined, cv.phoneNumber),
                  infoItem(Icons.location_on_outlined, '${cv.province.name} - ${cv.address}')
                ],
              )
          ),
          buildForm(
            buildHeader('MỤC TIÊU NGHỀ NGHIỆP', Icons.flag_outlined),
            Text('${cv.careerObjective}', style: TextStyle(color: Colors.grey[700],), softWrap: true,),
          ),
          cv.studentSkills.isEmpty ? Container() :
              buildForm(
                buildHeader('KỸ NĂNG', Icons.engineering_outlined),
                buildSkill(cv.studentSkills)
              ),
          cv.certificates.isEmpty ? Container() :
              buildForm(
                  buildHeader('CHỨNG CHỈ', Icons.workspace_premium_outlined),
                  Column(
                    children: [
                      for(var certificate in cv.certificates)
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text('- ${certificate.name}', style: TextStyle(color: Colors.grey[700],), softWrap: true,),
                        )
                    ],
                  )
              ),
          cv.hobbies.isEmpty ? Container() :
              buildForm(
                  buildHeader('SỞ THÍCH', Icons.sports_soccer_outlined),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var hobby in cv.hobbies)
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text('- ${hobby.name}', style: TextStyle(color: Colors.grey[700],), softWrap: true,),
                        )
                    ],
                  )
              ),
          cv.referencePeople.isEmpty ? Container() :
              buildForm(
                  buildHeader('NGƯỜI THAM CHIẾU', Icons.person_outlined),
                  buildReferencePerson(cv.referencePeople)
              ),
        ],
      ),
    ),
  );
}

Widget buildRight(CV cv) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    padding: EdgeInsets.all(20),
    color: Colors.white,
    child: IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildForm(
              buildHeader('TRÌNH ĐỘ HỌC VẤN', Icons.school_outlined),
              buildEducation(cv.educations)
          ),
          cv.experiences.isEmpty ? Container() :
            buildForm(
                buildHeader('KINH NGHIỆM LÀM VIỆC', Icons.work_outline),
                buildExperience(cv.yearOfExperience, cv.experiences)
            ),
          buildForm(
              buildHeader('HOẠT ĐỘNG', Icons.sports_soccer_outlined),
              buildActivity(cv.activities)
          ),
          buildForm(
              buildHeader('DỰ ÁN THAM GIA', Icons.groups_outlined),
              buildProject(cv.projects)
          ),
        ],
      ),
    ),
  );
}

Widget buildForm(Widget header, Widget body) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        header,
        SizedBox(height: 10,),
        body
      ],
    ),
  );
}

Widget buildHeader(String lable, IconData icon) {
  return Container(
    padding: EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 1, color: Colors.black))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(lable, style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w500), softWrap: true,),
        Icon(icon, size: 28,)
      ],
    ),
  );
}

Widget buildSex(bool? sex) {
  if(sex == null)
    return Container();
  if(sex)
    return infoItem(Icons.female_outlined, "Nữ");
  return infoItem(Icons.male_outlined, "Nam");
}

Widget infoItem(IconData icon, String lable) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    child: Expanded(
      child: Row(
        children: [
          Icon(
              icon,
              size: 32,
              color: Color.fromARGB(255, 31, 126, 208),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(lable,
              style: TextStyle(color: Colors.grey[700],),
              softWrap: true,
            ),
          )
        ],
      ),
    ),
  );
}