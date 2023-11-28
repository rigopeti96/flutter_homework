class CreateUserResponse {
  final String name;
  final String username;
  final String password;
  final String email;
  final Set<String> roles;

  const CreateUserResponse({
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.roles,
  });

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      roles: json['roles'] as Set<String>,
    );
  }
}