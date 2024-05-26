class RegisterEmployer {
  final String username;
  final String password;
  final String name;
  final String email;

  RegisterEmployer({
    required this.username,
    required this.password,
    required this.name,
    required this.email
  });

  Map<String, dynamic> toJson() {
    return{
      'username':  this.username,
      'password': this.password,
      'name': this.name,
      'email': this.email
    };
  }
}