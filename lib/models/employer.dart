class Employer {
  int id;
  String name;
  String email;
  String? description;
  String? avatarUrl;

  Employer({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.avatarUrl,
  });

  Employer.empty()
      : id = 0,
        name = '',
        email = '',
        description = null,
        avatarUrl = null;

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      description: json['description'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'name': this.name,
      'email': this.email,
      'description': this.description,
      'avatarUrl': this.avatarUrl
    };
  }

  Employer copyWith({
    int? id,
    String? name,
    String? email,
    String? description,
    String? avatarUrl,
  }) {
    return Employer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
