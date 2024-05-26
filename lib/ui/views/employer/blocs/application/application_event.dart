part of 'application_bloc.dart';

@immutable
sealed class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends ApplicationEvent {
  final String? title;
  final String? status;
  final String page;

  const LoadEvent({required this.title,
    required this.status,
    required this.page});

  @override
  List<Object?> get props => [title, status, page];
}

class UpdateStatus extends ApplicationEvent {
  final LoadSuccess data;
  final String? status;
  final int index;

  const UpdateStatus({required this.data,
    required this.status,
    required this.index});

  @override
  List<Object?> get props => [data, status, index];
}

class DeleteEvent extends ApplicationEvent {
  final LoadSuccess data;
  final Map<String, String> params;

  const DeleteEvent({required this.data, required this.params});

  @override
  List<Object?> get props => [data, params];
}