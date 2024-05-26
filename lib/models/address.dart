import '../models/province.dart';

class Address {
  final Province province;
  final String address;

  Address({
    required this.province,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return{
      'province':  this.province.toJson(),
      'address': this.address
    };
  }

  Address.empty()
      : province = Province.empty(),
        address = '';

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      province: Province.fromJson(json['province']),
      address: json['address'],
    );
  }

  Address copyWith({
    Province? province,
    String? address
  }) {
    return Address(
      province: province ?? this.province,
      address: address ?? this.address,
    );
  }
}