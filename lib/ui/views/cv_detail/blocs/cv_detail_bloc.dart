import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../models/cv.dart';
import '../../../../repositories/cv_repository.dart';

part 'cv_detail_event.dart';
part 'cv_detail_state.dart';

class CVDetailBloc extends Bloc<CVDetailEvent, CVDetailState> {
  final CVRepository _cvRepository = CVRepository();

  CVDetailBloc() : super(CVInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<CVDetailState> emit) async {
    try {
      Response<dynamic> response = await _cvRepository.getById(id: event.id);

      CV cv = CV.fromJson(response.data);
      emit(LoadSuccess(cv: cv));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }
}