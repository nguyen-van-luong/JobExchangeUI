class IndustryDto {
  String name;
  List<int> fatherIndustryId;
  List<int> subIndustryId;

  IndustryDto({required this.name,
    required this.fatherIndustryId,
    required this.subIndustryId});

  Map<String, dynamic> toJson() {
    return{
      'name': this.name,
      'fatherIndustryId': this.fatherIndustryId,
      'subIndustryId': this.subIndustryId
    };
  }
}