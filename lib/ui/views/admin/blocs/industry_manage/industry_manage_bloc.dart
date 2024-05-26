import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/industry.dart';
import 'package:untitled1/repositories/industry_repository.dart';

import '../../../../../dtos/industry_dto.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../dtos/result_count.dart';
import '../../../../router.dart';

part 'industry_manage_event.dart';
part 'industry_manage_state.dart';

class IndustryManageBloc extends Bloc<IndustryManageEvent, IndustryManageState> {
  final IndustryRepository _industryRepository = IndustryRepository();

  IndustryManageBloc() : super(IndustryManageInitialState()) {
    on<LoadEvent>(_onLoad);
    // on<UpdateStatus>(_onUpdateState);
    on<DeleteEvent>(_onDelete);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<IndustryManageState> emit) async {
    try {
      Response<dynamic> response = await _industryRepository.getSearch(
        page: int.parse(event.page),
        name: event.name
      );

      ResultCount<Industry> industries = ResultCount.fromJson(response.data, Industry.fromJson, Industry.empty());
      List<bool> isCheckeds  = industries.resultList.map((e) => false).toList();
      emit(LoadSuccess(result: industries, isCheckeds: isCheckeds, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onUpdateState(
      UpdateStatus event, Emitter<IndustryManageState> emit) async {
    try {
      await _industryRepository.update(industry: event.industry);
      appRouter.go('/industry_manage/name=${event.params['name'] ?? ""}&page=${event.params['page'] ?? '1'}');
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }

  Future<void> _onDelete(
      DeleteEvent event, Emitter<IndustryManageState> emit) async {
    try {
      List<Industry> industries = event.data.result.resultList;
      List<int> ids = [];
      List<bool> isCheckeds = event.data.isCheckeds;
      for(int i = 0; i < isCheckeds.length; i++) {
        if(isCheckeds[i])
          ids.add(industries[i].id);
      }
      await _industryRepository.deleteList(ids: ids);
      appRouter.go('/industry_manage/name=${event.params['name'] ?? ""}&page=${event.params['page'] ?? '1'}');
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }

  Future<void> _onAdd(
      CreateEvent event, Emitter<IndustryManageState> emit) async {
    try {
      await _industryRepository.create(industryDto: event.industryDto);
      appRouter.go('/industry_manage/name=${event.params['name'] ?? ""}&page=${event.params['page'] ?? '1'}');
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message msg = Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(result: event.data.result, isCheckeds: event.data.isCheckeds, message: msg));
    }
  }
}