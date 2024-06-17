import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/models/role.dart';
import 'package:untitled1/ui/router.dart';

import '../../../dtos/jwt_payload.dart';
import '../../../global_variable_model.dart';
import '../user_avatar.dart';
import 'package:provider/provider.dart';

class ItemMenu {
  ItemMenu({required this.name, required this.icon, required this.route});

  final String name;
  final IconData icon;
  final String route;
}

class RightHeader extends StatefulWidget {
  const RightHeader({super.key});
  

  @override
  State<RightHeader> createState() => _RightHeaderState();
}

class _RightHeaderState extends State<RightHeader> {
  List<ItemMenu> profilerMenu = [
    ItemMenu(
        name: "Trang cá nhân",
        icon: Icons.person,
        route: JwtPayload.role == 'ROLE_employer' ? "/employer_manage" : "/student_manage"),
    ItemMenu(
        name: "Đổi mật khẩu", icon: Icons.change_circle, route: "/changepass"),
    ItemMenu(name: "Quên mật khẩu", icon: Icons.vpn_key, route: "/forgotpass"),
    ItemMenu(name: "Đăng xuất", icon: Icons.logout, route: "/logout")
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        (JwtPayload.sub == null)
            ? Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(minWidth: 120),
                child: FilledButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 66, 133, 244)) ),
                  onPressed: () =>  appRouter.go('/login'),
                  child: const Text("Đăng Nhập",
                      style: TextStyle(color: Colors.white),
                      softWrap: false,
                      maxLines: 1),
                ),
              )
            : widgetSignIn()
      ],
    );
  }

  Widget widgetSignIn() => Row(
        children: [
          buildButtonNotification(),
          SizedBox(width: 10,),
          MenuAnchor(
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
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserAvatar(
                        imageUrl: JwtPayload.avatarUrl ?? '', size: 32)),
                iconSize: 32,
                splashRadius: 16,
                tooltip: 'Profiler',
              );
            },
            menuChildren: List<MenuItemButton>.generate(
              profilerMenu.length,
              (int index) => MenuItemButton(
                  onPressed: () =>
                      {GoRouter.of(context).go(profilerMenu[index].route)},
                  child: Row(
                    children: [
                      Icon(profilerMenu[index].icon),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(profilerMenu[index].name)
                    ],
                  )),
            ),
          ),
        ],
      );

  Widget buildButtonNotification() {
    return Consumer<GlobalVariableModel>(
      builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<GlobalVariableModel>(context, listen: false).hasMessage = false;
                });

                appRouter.go("/employer_notification");
                // Xử lý sự kiện khi nhấn vào icon
              },
            ),
            if (model.hasMessage)
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
  

