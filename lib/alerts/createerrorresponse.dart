class CreateErrorResponse {
  final String id;
  final String reportType;
  final String stationName;
  final String transportType;
  final double latitude;
  final double longitude;
  final String reportDate;
  final String reportDateUntil;
  final String reporterName;
  final String modifierName;

  const CreateErrorResponse({
    required this.id,
    required this.reportType,
    required this.stationName,
    required this.transportType,
    required this.latitude,
    required this.longitude,
    required this.reportDate,
    required this.reportDateUntil,
    required this.reporterName,
    required this.modifierName,
  });

  factory CreateErrorResponse.fromJson(Map<String, dynamic> json) {
    return CreateErrorResponse(
      id: json['id'] as String,
      reportType: json['reportType'] as String,
      stationName: json['stationName'] as String,
      transportType: json['transportType'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      reportDate: json['reportDate'] as String,
      reportDateUntil: json['reportDateUntil'] as String,
      reporterName: json['reporterName'] as String,
      modifierName: json['modifierName'] as String,
    );
  }
}