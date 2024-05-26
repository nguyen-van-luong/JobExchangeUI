
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/router.dart';
import 'package:untitled1/ui/views/login/blocs/login_bloc.dart';

import '../../widgets/notification.dart';

class LoginView extends StatefulWidget {
  const LoginView();

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late LoginBloc _bloc;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if(state is LoginFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showTopRightSnackBar(context, state.message, state.notifyType);
            });
          }
          return Scaffold(
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    color: Color.fromARGB(255, 238, 238, 238),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    constraints: const BoxConstraints.expand(),
                    child: Center(
                        child: IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            width: 480,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                                  child: Text("Đăng nhập",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30)),
                                ),
                                Container(
                                  width: 380,
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                  child: TextField(
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Username',
                                      labelStyle: const TextStyle(
                                          color: Color(0xff888888),
                                          fontSize: 15),
                                      errorText: state is LoginInvalid && state.usernameInvalid ? 'Invalid username' : null,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 380,
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                  child: TextField(
                                    controller: _passwordController,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      labelStyle: const TextStyle(
                                          color: Color(0xff888888),
                                          fontSize: 15),
                                      errorText: state is LoginInvalid && state.passwordInvalid ? 'Invalid password' : null,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                        },
                                        child: const MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            "Quên mật khẩu",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {_showRegisterDialog(context);},
                                          child: const MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Text("Đăng ký",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue))))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                  child: SizedBox(
                                    height: 48,
                                    width: 200,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 86, 143))
                                      ),
                                      onPressed: () {
                                        _bloc.add(LoginSubmitEvent(username: _usernameController.text, password: _passwordController.text));
                                      },
                                      child: Text('Đăng nhập', style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  _showRegisterDialog(
      BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Đăng ký'),
          content: const Text(
              'Bạn có thể đăng ký tai khoản sinh viên hoặc nhà tuyển dụng'),
          actions: <Widget>[
            SizedBox(
              width: 150,
              height: 40,
              child: FloatingActionButton(
                child: const Text('Đăng ký sinh viên'),
                onPressed: () {
                  appRouter.go("/register_student");
                },
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: FloatingActionButton(
                child: const Text('Đăng ký nhà tuyển dụng'),
                onPressed: () {
                  appRouter.go("/register_employer");
                },
              ),
            ),
          ],
        );
      },
    ); // Thêm '?? false' ở đây
  }
}