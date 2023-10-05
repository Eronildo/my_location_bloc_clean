import '../../../../core/adapters/local_storage/local_storage_adapter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/location_history_model.dart';

/// Local storage key for list of location histories.
const locationHistoriesKey = 'locationHistories';

///
abstract class LocationLocalDataSource {
  ///
  Future<void> saveLocationHistories(
    List<LocationHistoryModel> locationHistories,
  );

  /// Calls the {BaseApi}/json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  List<LocationHistoryModel> getLocationHistories();
}

///
class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  ///
  LocationLocalDataSourceImpl({
    required this.localStorageAdapter,
  });

  ///
  final LocalStorageAdapter localStorageAdapter;

  @override
  List<LocationHistoryModel> getLocationHistories() {
    final locationHistoryListMap =
        localStorageAdapter.get(locationHistoriesKey);

    if (locationHistoryListMap == null) return [];

    final historiesMap = locationHistoryListMap[locationHistoriesKey] as List;

    return List<LocationHistoryModel>.from(
      historiesMap
          .map((e) => LocationHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<void> saveLocationHistories(
    List<LocationHistoryModel> locationHistories,
  ) async {
    await localStorageAdapter.save(
      locationHistoriesKey,
      {
        locationHistoriesKey: locationHistories.map((e) => e.toJson()).toList(),
      },
    );
  }
}
