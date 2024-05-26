import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/repositories/follow_repository.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../dtos/result_count.dart';
import '../../../../../models/follow.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FollowRepository _followRepository = FollowRepository();

  FollowBloc() : super(FollowInitialState()) {
    on<LoadEvent>(_onLoad);
    on<OnFollow>(_onBookmark);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<FollowState> emit) async {
    try {
      Response<dynamic> response = await _followRepository.getEmployerPage(page: event.page);
      ResultCount<Follow>? result = ResultCount.fromJson(response.data, Follow.fromJson, Follow.empty());
      List<bool> follows = [];
      for(int i = 0; i < result.resultList.length; i++) {
        follows.add(true);
      }
      emit(LoadSuccess(follows: follows, result: result, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onBookmark(
      OnFollow event, Emitter<FollowState> emit) async {
    try {
      String message = "Đánh dấu thành công!";
      if(event.isFollow) {
        _followRepository.follow(employerId: event.data.result!.resultList[event.index].employer.id);
      } else {
        _followRepository.unFollow(employerId: event.data.result!.resultList[event.index].employer.id);
        message = "Đã hũy đánh dấu!";
      }
      event.data.follows[event.index] = event.isFollow;
      Message successMsg =  Message(message: message, notifyType: NotifyType.success);

      emit(LoadSuccess(follows: event.data.follows, result: event.data.result, message: successMsg));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(follows: event.data.follows, result: event.data.result, message: loadFailure));
    }
  }
}