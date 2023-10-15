import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class OWCitiesFindResponse{
  final String message;
  final String cod;
  final num count;

  OWCitiesFindResponse(this.message, this.cod, this.count);

  factory OWCitiesFindResponse.fromJson(Map<String, dynamic> json) => _$OWCitiesFindResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OWCitiesFindResponseToJson(this);
}