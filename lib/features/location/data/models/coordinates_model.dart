import '../../domain/entities/coordinates.dart';

///
class CoordinatesModel extends Coordinates {
  ///
  const CoordinatesModel({
    required super.latitude,
    required super.longitude,
  });

  ///
  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      latitude: json['lat'] as double,
      longitude: json['lon'] as double,
    );
  }

  ///
  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
    };
  }
}
