import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ui/widgets/user_avatar.dart';

import '../../models/student.dart';
import '../router.dart';

class StudentFeedItem extends StatelessWidget {
  final Student student;

  const StudentFeedItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return _buildContainer( student);
  }

  Container _buildContainer(Student student) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: student.fullname == "" ? null :
                    () => appRouter.go("/student/${student.id}"),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserAvatar(
                      imageUrl: student!.avatarUrl,
                      size: 64,
                    )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: InkWell(
                        onTap: student.fullname == "" ? null :
                            () => appRouter.go("/student/${student.id}"),
                        hoverColor: Colors.black12,
                        child: Text(
                          student.fullname == "" ?
                          'Sinh viên không còn tồn tại' : student.fullname,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: Row(
                        children: [
                          buildField(student.email, Icons.email_outlined),
                          SizedBox(width: 20,),
                          buildField(DateFormat('dd/MM/yyyy').format(student.birthday ?? DateTime.now()), Icons.cake_outlined)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],

      ),
    );
  }

  Widget buildField(String str, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.black38, size: 24,),
        SizedBox(width: 10,),
        Text(str, style: TextStyle(color: Colors.black38, fontSize: 16),)
      ],
    );
  }

}