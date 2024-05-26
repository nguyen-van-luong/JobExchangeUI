class RegisterStudent {
  final String username;
  final String password;
  final String fullname;
  final String email;

  RegisterStudent({
    required this.username,
    required this.password,
    required this.fullname,
    required this.email
  });

  Map<String, dynamic> toJson() {
    return{
      'username':  this.username,
      'password': this.password,
      'fullname': this.fullname,
      'email': this.email
    };
  }
}