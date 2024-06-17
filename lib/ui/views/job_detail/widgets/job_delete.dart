import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/router.dart';

import '../../../widgets/notification.dart';
import '../blocs/job_detail_bloc.dart';

class JobDeleteView extends StatefulWidget {
  const JobDeleteView({super.key, required this.id});
  final String? id;

  @override
  State<JobDeleteView> createState() => _JobDeleteViewState();
}

class _JobDeleteViewState extends State<JobDeleteView> {

  late JobDetailBloc _bloc;
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
      _bloc = JobDetailBloc();
      _bloc.add(LoadEvent(id: widget.id!));
      return _bloc;
    },
    child: BlocBuilder<JobDetailBloc, JobDetailState>(
        builder: (context, state) {
          if(state is Message) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showTopRightSnackBar(context, state.message, state.notifyType);
            });
            appRouter.go('/job_manage');
          }
          return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        }
    )
    );
  }
}