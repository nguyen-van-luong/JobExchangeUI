import 'package:flutter/cupertino.dart';

import '../../../../dtos/result_count.dart';
import '../../../../models/cv.dart';
import '../../../common/utils/widget.dart';
import '../../../widgets/pagination.dart';

Widget buildCVs(ResultCount<CV> result, Map<String, String> params, String studentId) {
  List<CV> jobs = result.resultList;
  return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          for(int i = 0 ;i < jobs.length;i = i + 2)
            buildItemCVRow(jobs[i], i + 1 < jobs.length ? jobs[i + 1] : null, true),
          Pagination(
            path: '/student/$studentId',
            totalItem: result.count,
            params: params,
            selectedPage: int.parse(params['page'] ?? "1"),
          )
        ],
      )
  );
}