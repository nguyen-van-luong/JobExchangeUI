import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/employer.dart';
import 'package:untitled1/repositories/employer_repository.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../dtos/result_count.dart';

part 'employers_event.dart';
part 'employers_state.dart';

class EmployersBloc extends Bloc<EmployersEvent, EmployersState> {
  final EmployerRepository _employerRepository = EmployerRepository();

  EmployersBloc() : super(EmployersInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<EmployersState> emit) async {
    try {
      Response<dynamic> response =  await _employerRepository.getSearch(searchContent: event.searchContent, page: event.page ?? 1);

      ResultCount<Employer> employers = ResultCount.fromJson(response.data, Employer.fromJson, Employer.empty());
      emit(LoadSuccess(result: employers));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}