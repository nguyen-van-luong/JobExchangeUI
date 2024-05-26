part of 'cv_manage_bloc.dart';

@immutable
sealed class CVManageEvent extends Equatable {
  const CVManageEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CVManageEvent {
  final String? searchContent;
  final bool? isPrivate;
  final String page;

  const LoadEvent({required this.searchContent,
    required this.isPrivate,
    required this.page});

  @override
  List<Object?> get props => [searchContent, isPrivate, page];
}

class UpdatePrivate extends CVManageEvent {
  final LoadSuccess data;
  final bool? isPrivate;
  final int index;

  const UpdatePrivate({required this.data,
    required this.isPrivate,
    required this.index});

  @override
  List<Object?> get props => [data, isPrivate, index];
}

class DeleteEvent extends CVManageEvent {
  final LoadSuccess data;
  final Map<String, String> params;

  const DeleteEvent({required this.data, required this.params});

  @override
  List<Object?> get props => [data, params];
}