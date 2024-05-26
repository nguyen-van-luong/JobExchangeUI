import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/router.dart';
import 'package:untitled1/ui/views/logout/bloc/logout_bloc.dart';

class LogoutView extends StatefulWidget {
  const LogoutView({super.key});

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  late LogoutBloc _bloc;

  @override
  void initState() {
    _bloc = LogoutBloc()
      ..add(LoadEvent());
  }

  @override
  void didUpdateWidget(LogoutView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return _bloc;
        },
        child: BlocBuilder<LogoutBloc, LogoutState>(
          builder: (context, state) {
            if (state is LoadSuccess) {
              appRouter.go('/login');
            }
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
        )
    );
  }
}