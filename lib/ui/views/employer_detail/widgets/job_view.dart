import 'package:flutter/cupertino.dart';
import 'package:untitled1/dtos/result_count.dart';

import '../../../../models/job.dart';
import '../../../common/utils/widget.dart';
import '../../../widgets/pagination.dart';

Widget buildJobs(ResultCount<Job> result, Map<String, String> params, String employerId) {
  List<Job> jobs = result.resultList;
  return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          for(int i = 0 ;i < jobs.length;i = i + 2)
            buildItemJobRow(jobs[i], i + 1 < jobs.length ? jobs[i + 1] : null, true),
          Pagination(
            path: '/employer/$employerId',
            totalItem: result.count,
            params: params,
            selectedPage: int.parse(params['page'] ?? "1"),
          )
        ],
      )
  );
}