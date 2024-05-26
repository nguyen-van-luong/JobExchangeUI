part of 'cu_job_bloc.dart';

@immutable
sealed class CUJobEvent extends Equatable {
  const CUJobEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CUJobEvent {
  final int? id;
  const LoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SaveEvent extends CUJobEvent {
  final JobDto job;
  const SaveEvent({required this.job});

  @override
  List<Object?> get props => [job];
}

class UpdateEvent extends CUJobEvent {
  final JobDto job;
  final int id;
  const UpdateEvent({required this.job, required this.id});

  @override
  List<Object?> get props => [job, id];
}