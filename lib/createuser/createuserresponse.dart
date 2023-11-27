class CrateUserResponse {
  final String name;
  final String username;
  final String password;
  final String email;
  final List<String> roles;

  const CrateUserResponse({
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.roles,
  });

  factory CrateUserResponse.fromJson(Map<String, dynamic> json) {
    return CrateUserResponse(
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      roles: json['roles'] as List<String>,
    );
  }
}