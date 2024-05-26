class Student {
  int id;
  String fullname;
  DateTime? birthday;
  String email;
  String? avatarUrl;
  bool? gender;
  String? address;
  String? phoneNumber;

  Student({
    required this.id,
    required this.fullname,
    required this.email,
    required this.birthday,
    required this.avatarUrl,
    required this.address,
    required this.gender,
    required this.phoneNumber
  });

  Student.empty()
      : id = 0,
        fullname = '',
        email = '',
        birthday = DateTime.now(),
        avatarUrl = null,
        phoneNumber = '',
        gender = null,
        address = '';

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      birthday: json['birthday'] == null ? null : DateTime.tryParse(json['birthday']),
      avatarUrl: json['avatarUrl'],
      address: json['address'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber']
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'fullname': this.fullname,
      'email': this.email,
      'birthday':  this.birthday?.toIso8601String(),
      'avatarUrl': this.avatarUrl,
      'address': this.address,
      'gender': this.gender,
      'phoneNumber': this.phoneNumber
    };
  }

  Student copyWith({
    int? id,
    String? fullname,
    String? email,
    DateTime? birthday,
    String? avatarUrl,
    String? address,
    bool? gender,
    String? phoneNumber
  }) {
    return Student(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber
    );
  }
}
