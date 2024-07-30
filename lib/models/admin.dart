class Admin {
  final String email;
  final String refreshToken;
  final String accessToken;
  final int versionToken;
  final String version;

  Admin({
    required this.email,
    required this.refreshToken,
    required this.accessToken,
    required this.versionToken,
    required this.version,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      email: json['email'],
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
      versionToken: json['versionToken'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'refreshToken': refreshToken,
      'accessToken': accessToken,
      'versionToken': versionToken,
      'version': version,
    };
  }
}
