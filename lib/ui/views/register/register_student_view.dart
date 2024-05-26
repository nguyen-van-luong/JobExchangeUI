
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/router.dart';

import '../../../dtos/register_student.dart';
import '../../widgets/notification.dart';
import 'blocs/register_bloc.dart';

class RegisterStudentView extends StatefulWidget {
  const RegisterStudentView();

  @override
  State<RegisterStudentView> createState() => _RegisterStudentViewState();
}

class _RegisterStudentViewState extends State<RegisterStudentView> {

  late RegisterBloc _bloc;
  bool checkRePassword = false;
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = RegisterBloc();
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
      child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if(state is RegisterSuccess) {
              appRouter.go("/login");
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if(state is RegisterFailure) {
                showTopRightSnackBar(context, state.message, state.notifyType);
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
                                child: SingleChildScrollView(child: Column(
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                                      child: Text("Đăng ký sinh viên",
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
                                        controller: _fullnameController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Họ và  tên',
                                          labelStyle: const TextStyle(
                                              color: Color(0xff888888),
                                              fontSize: 15),
                                          errorText: state is RegisterEmployerInvalid && state.nameInvalid ? 'Họ và tên không được để rống' : null,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 380,
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Email',
                                          labelStyle: const TextStyle(
                                              color: Color(0xff888888),
                                              fontSize: 15),
                                          errorText: state is RegisterEmployerInvalid && state.nameInvalid ? 'Email không được để rống' : null,
                                        ),
                                      ),
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
                                          labelText: 'Tên tài khoản',
                                          labelStyle: const TextStyle(
                                              color: Color(0xff888888),
                                              fontSize: 15),
                                          errorText: state is RegisterEmployerInvalid && state.usernameInvalid ? 'Tên tài khoản không đươợc để rống' : null,
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
                                          labelText: 'Mật khẩu',
                                          labelStyle: const TextStyle(
                                              color: Color(0xff888888),
                                              fontSize: 15),
                                          errorText: state is RegisterEmployerInvalid && state.passwordInvalid ? 'Mật khẩu không được để rống' : null,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 380,
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                        controller: _repasswordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Nhập lại mật khẩu',
                                          labelStyle: const TextStyle(
                                              color: Color(0xff888888),
                                              fontSize: 15),
                                          errorText: errorRePassword(state),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: GestureDetector(
                                        onTap: () {
                                          appRouter.go("/login");
                                        },
                                        child: const MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            "Đăng nhập",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.blue),
                                          ),
                                        ),
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
                                          onPressed: () => _bloc.add(RegisterStudentSubmitEvent(
                                              registerStudent: RegisterStudent(username: _usernameController.text,
                                                  password: _passwordController.text,
                                                  fullname: _fullnameController.text,
                                                  email: _emailController.text),
                                              repassword: _repasswordController.text
                                          )),
                                          child: Text('Đăng ký', style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),
                      ));
                    }),
              );
            },
          )
      ),
    );
  }

  String? errorRePassword(RegisterState state) {
    if(_passwordController.text != _repasswordController.text) {
      return "Mật khẩu không hớp!";
    }
    else if(state is RegisterEmployerInvalid && _repasswordController.text.isEmpty) {
      return "Nhập lại mật khẩu không được để rỗng!";
    }

    return null;
  }
}