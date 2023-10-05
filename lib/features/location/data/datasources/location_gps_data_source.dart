import '../../../../core/adapters/location/location_adapter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/coordinates_model.dart';

///
abstract class LocationGpsDataSource {
  /// Get Coordinates via GPS.
  ///
  /// Throws a [LocationException].
  Future<CoordinatesModel> getCoordinates();
}

///
class LocationGpsDataSourceImpl implements LocationGpsDataSource {
  ///
  const LocationGpsDataSourceImpl({required this.locationAdapter});

  ///
  final LocationAdapter locationAdapter;

  @override
  Future<CoordinatesModel> getCoordinates() => _getCoordinates();

  Future<CoordinatesModel> _getCoordinates() async {
    if (await locationAdapter.isLocationEnabled) {
      try {
        final (latitude, longitude) = await locationAdapter.currentLocation;

        return CoordinatesModel(latitude: latitude, longitude: longitude);
      } on LocationException {
        rethrow;
      }
    } else {
      throw LocationUnavailableException();
    }
  }
}
