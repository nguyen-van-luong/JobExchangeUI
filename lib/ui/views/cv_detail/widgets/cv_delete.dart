import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router.dart';
import '../../../widgets/notification.dart';
import '../blocs/cv_detail_bloc.dart';

class CVDeleteView extends StatefulWidget {
  const CVDeleteView({super.key, required this.id});
  final String? id;

  @override
  State<CVDeleteView> createState() => _CVDeleteViewState();
}

class _CVDeleteViewState extends State<CVDeleteView> {

  late CVDetailBloc _bloc;
  List<String> provinceStrs = [];

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          _bloc = CVDetailBloc();
          _bloc.add(LoadEvent(id: widget.id!));
          return _bloc;
        },
        child: BlocBuilder<CVDetailBloc, CVDetailState>(
            builder: (context, state) {
              if(state is Message) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTopRightSnackBar(context, state.message, state.notifyType);
                });
                appRouter.go('/cv_manage');
              }
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
        )
    );
  }
}