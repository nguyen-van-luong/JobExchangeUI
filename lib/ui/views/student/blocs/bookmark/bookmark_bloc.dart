import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/bookmark.dart';
import 'package:untitled1/repositories/bookmark_repository.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../dtos/result_count.dart';
import '../../../../../models/job.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BookmarkRepository _bookmarkRepository = BookmarkRepository();

  BookmarkBloc() : super(BookmarkInitialState()) {
    on<LoadEvent>(_onLoad);
    on<OnBookmark>(_onBookmark);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<BookmarkState> emit) async {
    try {
      Response<dynamic> response = await _bookmarkRepository.getJobPage(page: event.page);
      ResultCount<Bookmark>? result = ResultCount.fromJson(response.data, Bookmark.fromJson, Bookmark.empty());
      List<bool> bookmarks = [];
      for(int i = 0; i < result.resultList.length; i++) {
        bookmarks.add(true);
      }
      emit(LoadSuccess(bookmarks: bookmarks, result: result, message: null));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(Message(message: message, notifyType: NotifyType.error));
    }
  }

  Future<void> _onBookmark(
      OnBookmark event, Emitter<BookmarkState> emit) async {
    try {
      String message = "Theo dõi thành công!";
      if(event.isBookmark) {
        _bookmarkRepository.bookmark(jobId: event.data.result!.resultList[event.index].job.id);
      } else {
        _bookmarkRepository.unBookmark(jobId: event.data.result!.resultList[event.index].job.id);
        message = "Đã hũy theo dõi!";
      }
      event.data.bookmarks[event.index] = event.isBookmark;
      Message successMsg =  Message(message: message, notifyType: NotifyType.success);

      emit(LoadSuccess(bookmarks: event.data.bookmarks, result: event.data.result, message: successMsg));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      Message loadFailure =  Message(message: message, notifyType: NotifyType.error);
      emit(LoadSuccess(bookmarks: event.data.bookmarks, result: event.data.result, message: loadFailure));
    }
  }
}