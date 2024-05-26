import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/dtos/jwt_payload.dart';
import 'package:untitled1/ui/router.dart';

import '../../../widgets/header/right_header.dart';

class MenuAction extends StatefulWidget {
  final int? id;
  const MenuAction({super.key, required this.id});

  @override
  State<MenuAction> createState() => _MenuActionState();
}

class _MenuActionState extends State<MenuAction> {

  List<ItemMenu> acthorMenu = [
    ItemMenu(name: "Sửa", icon: Icons.edit, route: "/"),
    ItemMenu(name: "xóa", icon: Icons.delete, route: "/")
  ];

  List<ItemMenu> viewerMenu = [
    ItemMenu(name: "Báo cáo", icon: Icons.report, route: "/")
  ];

  @override
  Widget build(BuildContext context) {
    List<ItemMenu> itemMenu = widget.id == JwtPayload.userId ? acthorMenu : viewerMenu;
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
        itemMenu.length,
            (int index) => MenuItemButton(
            onPressed: () =>
            {appRouter.go(itemMenu[index].route)},
            child: Row(
              children: [
                Icon(itemMenu[index].icon),
                const SizedBox(
                  width: 20,
                ),
                Text(itemMenu[index].name)
              ],
            )),
      ),
    );
  }
}