class SignUpRequest {
  String name;
  String email;
  String password;
  String confirmPassword;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword" : confirmPassword
    };
  }
}