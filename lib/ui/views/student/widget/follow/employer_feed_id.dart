import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/employer.dart';

import '../../../../router.dart';
import '../../../../widgets/user_avatar.dart';

typedef FunctionCallback = Function(bool isFollow);

class EmployerFeedItem extends StatelessWidget {
  final FunctionCallback callback;
  final Employer employer;
  final bool isFollow;

  const EmployerFeedItem({super.key, required this.employer, required this.isFollow, required this.callback});

  @override
  Widget build(BuildContext context) {
    return _buildContainer(isFollow, employer);
  }

  Container _buildContainer(bool isFollow, Employer employer) {
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
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: InkWell(
                        onTap: employer.name == "" ? null :
                            () => appRouter.go("/employer/${employer.id}"),
                        hoverColor: Colors.black12,
                        child: Text(
                          employer.name == "" ?
                          'Nhà tuyển dụng không còn tồn tại' : employer.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 140,),
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                      side: BorderSide(color: isFollow ? Colors.redAccent : Colors.blueAccent, width: 3)
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () => callback(!isFollow),
                child: isFollow ? Text('Hũy theo dõi', style: TextStyle(fontSize: 16)) :
                Text('Theo dõi', style: TextStyle(fontSize: 16),),
              )
          )
        ],

      ),
    );
  }

  // Widget salaryView(int? salaryFrom, int? salaryTo) {
  //   String text = "";
  //   if(salaryFrom != null && salaryTo != null) {
  //     text = salaryFrom.toString() + " - " +salaryTo.toString() + " triệu";
  //   } else {
  //     text = (salaryFrom.toString() ?? "") + (salaryTo.toString() ?? "") + " triệu";
  //   }
  //
  //   return Container(
  //     child: Row(
  //       children: [
  //         Icon(
  //           Icons.attach_money,
  //           size: 16,
  //           color: Colors.grey[700],
  //         ),
  //         const SizedBox(width: 2),
  //         Text(text,
  //             style: TextStyle(fontSize: 13, color: Colors.grey[700])),
  //       ],
  //     ),
  //   );
  // }

  // Widget addressView(List<Address> addresses) {
  //   String text = addresses[0].province.name;
  //   if(addresses.length > 1) {
  //     text += ' & ${addresses.length - 1} nơi khác';
  //   }
  //
  //   return Container(
  //     child: Row(
  //       children: [
  //         Icon(
  //           Icons.location_on_outlined,
  //           size: 16,
  //           color: Colors.grey[700],
  //         ),
  //         const SizedBox(width: 2),
  //         Text(text,
  //             style: TextStyle(fontSize: 13, color: Colors.grey[700])),
  //       ],
  //     ),
  //   );
  // }
}