import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/jwt_payload.dart';
import 'package:untitled1/ui/router.dart';

import '../../../../repositories/job_repository.dart';
import '../../../widgets/header/right_header.dart';

class MenuAction extends StatefulWidget {
  final int? id;
  const MenuAction({super.key, required this.id});

  @override
  State<MenuAction> createState() => _MenuActionState();
}

class _MenuActionState extends State<MenuAction> {

  late List<ItemMenu> acthorMenu;

  // List<ItemMenu> viewerMenu = [
  //   ItemMenu(name: "Báo cáo", icon: Icons.report, route: "/")
  // ];

  @override
  Widget build(BuildContext context) {
    acthorMenu = [
      ItemMenu(name: "Sửa", icon: Icons.edit, route: "/cu_job/id=${widget.id}"),
      ItemMenu(name: "xóa", icon: Icons.delete, route: "/delete_job/id=${widget.id}")
    ];
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller,
          Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon:const Icon(Icons.more_horiz),
          iconSize: 32,
          splashRadius: 16,
          tooltip: 'Profiler',
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        acthorMenu.length,
            (int index) => MenuItemButton(
            onPressed: () =>
            {appRouter.go(acthorMenu[index].route)},
            child: Row(
              children: [
                Icon(acthorMenu[index].icon),
                const SizedBox(
                  width: 20,
                ),
                Text(acthorMenu[index].name)
              ],
            )),
      ),
    );
  }
}