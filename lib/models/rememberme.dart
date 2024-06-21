class Rememberme {
  String email;
  String password;

  Rememberme({required this.email, required this.password});

  // Convert a Viet61 object into a map (JSON format)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Create a Viet61 object from a map (JSON format)
  factory Rememberme.fromJson(Map<String, dynamic> json) {
    return Rememberme(
      email: json['email'],
      password: json['password'],
    );
  }
}
