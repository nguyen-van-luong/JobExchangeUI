class User {
  int id;
  int userId;
  String username;
  String role;

  User({
    required this.id,
    required this.userId,
    required this.username,
    required this.role,
  });

  User.empty()
      : id = 0,
        userId = 0,
        username = '',
        role = '';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      role: json['role'],
    );
  }

  User copyWith({
    int? id,
    int? userId,
    String? username,
    String? avatarUrl,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      role: role ?? this.role,
    );
  }
}
