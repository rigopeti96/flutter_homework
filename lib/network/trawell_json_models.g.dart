part of 'trawell_json_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(
    Map<String, dynamic> json) =>
    LoginResponse(
      json['accessToken'] as String,
      json['id'] as String,
      json['employeename'] as String,
      json['email'] as String,
      json['enabled'] as bool,
      json['roles'] as List<String>,
    );

Map<String, dynamic> _$OWLoginResponseToJson(
    LoginResponse instance) =>
    <String, dynamic>{
        'accessToken': instance.accessToken,
        'id': instance.id,
        'employeename': instance.employeename,
        'email': instance.email,
        'enabled': instance.enabled,
        'roles': instance.roles
    };