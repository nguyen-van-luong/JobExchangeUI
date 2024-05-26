part of 'industry_manage_bloc.dart';

@immutable
sealed class IndustryManageEvent extends Equatable {
  const IndustryManageEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends IndustryManageEvent {
  final String name;
  final String page;

  const LoadEvent({
    required this.name,
    required this.page});

  @override
  List<Object?> get props => [name, page];
}

class UpdateStatus extends IndustryManageEvent {
  final LoadSuccess data;
  final Industry industry;
  final Map<String, String> params;

  const UpdateStatus({required this.data,required this.industry, required this.params});

  @override
  List<Object?> get props => [data, industry, params];
}

class DeleteEvent extends IndustryManageEvent {
  final LoadSuccess data;
  final Map<String, String> params;

  const DeleteEvent({required this.data, required this.params});

  @override
  List<Object?> get props => [data, params];
}

class CreateEvent extends IndustryManageEvent {
  final LoadSuccess data;
  final IndustryDto industryDto;
  final Map<String, String> params;

  const CreateEvent({required this.data,required this.industryDto, required this.params});

  @override
  List<Object?> get props => [data, industryDto, params];
}