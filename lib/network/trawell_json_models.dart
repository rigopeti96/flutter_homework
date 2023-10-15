import 'package:json_annotation/json_annotation.dart';

part 'trawell_json_models.g.dart';

@JsonSerializable()
class LoginResponse{
  final String accessToken;
  final String id;
  final String employeename;
  final String email;
  final bool enabled;
  final List<String> roles;

  LoginResponse(
    this.accessToken,
    this.id,
    this.employeename,
    this.email,
    this.enabled,
    this.roles,
  );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OWLoginResponseToJson(this);
}