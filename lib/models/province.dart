class Province {
  int id;
  String name;
  DateTime? updatedAt;

  Province({
    required this.id,
    required this.name,
    required this.updatedAt,
  });

  Province.empty()
      : id = 0,
        name = '',
        updatedAt = null;

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Province copyWith({
    int? id,
    String? name,
    DateTime? updatedAt
  }) {
    return Province(
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
    'id':  this.id,
    'name': this.name,
    'updatedAt':  this.updatedAt?.toIso8601String()
    };
  }
}
