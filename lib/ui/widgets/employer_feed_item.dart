import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/employer.dart';
import 'package:untitled1/ui/widgets/user_avatar.dart';

import '../router.dart';

class EmployerFeedItem extends StatelessWidget {
  final Employer employer;

  const EmployerFeedItem({super.key, required this.employer});

  @override
  Widget build(BuildContext context) {
    return _buildContainer( employer);
  }

  Container _buildContainer(Employer employer) {
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
                onTap: employer.name == "" ? null :
                    () => appRouter.go("/employer/${employer.id}"),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserAvatar(
                      imageUrl: employer!.avatarUrl,
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
                        onTap: employer.name == "" ? null :
                            () => appRouter.go("/employer/${employer.id}"),
                        hoverColor: Colors.black12,
                        child: Text(
                          employer.name == "" ?
                          'Sinh viên không còn tồn tại' : employer.name,
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
                      child: buildField(employer.email, Icons.email_outlined),
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