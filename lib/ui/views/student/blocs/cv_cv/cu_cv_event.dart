part of 'cu_cv_bloc.dart';

@immutable
sealed class CUCVEvent extends Equatable {
  const CUCVEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CUCVEvent {
  final int? id;
  const LoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SaveEvent extends CUCVEvent {
  final CVDto cv;
  const SaveEvent({required this.cv});

  @override
  List<Object?> get props => [cv];
}

class UpdateEvent extends CUCVEvent {
  final CVDto cv;
  final int id;
  const UpdateEvent({required this.cv, required this.id});

  @override
  List<Object?> get props => [cv, id];
}