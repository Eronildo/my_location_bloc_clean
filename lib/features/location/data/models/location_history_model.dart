import '../../domain/entities/location_history.dart';
import 'coordinates_model.dart';

///
class LocationHistoryModel extends LocationHistory {
  ///
  const LocationHistoryModel({
    required super.coordinates,
    required super.historyDate,
  });

  ///
  factory LocationHistoryModel.fromEntity(LocationHistory locationHistory) =>
      LocationHistoryModel(
        coordinates: locationHistory.coordinates,
        historyDate: locationHistory.historyDate,
      );

  ///
  factory LocationHistoryModel.fromJson(Map<String, dynamic> json) {
    return LocationHistoryModel(
      coordinates: CoordinatesModel.fromJson(
        json['coordinates'] as Map<String, dynamic>,
      ),
      historyDate: DateTime.fromMillisecondsSinceEpoch(
        json['historyDate'] as int,
      ),
    );
  }

  ///
  Map<String, dynamic> toJson() {
    return {
      'coordinates': (coordinates as CoordinatesModel).toJson(),
      'historyDate': historyDate.millisecondsSinceEpoch,
    };
  }
}
