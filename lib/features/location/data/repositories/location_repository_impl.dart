import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/coordinates.dart';
import '../../domain/entities/location_history.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_api_data_source.dart';
import '../datasources/location_gps_data_source.dart';
import '../datasources/location_local_data_source.dart';
import '../models/location_history_model.dart';

///
class LocationRepositoryImpl implements LocationRepository {
  ///
  LocationRepositoryImpl({
    required this.locationGpsDataSource,
    required this.locationApiDataSource,
    required this.locationLocalDataSource,
  });

  ///
  LocationGpsDataSource locationGpsDataSource;

  ///
  LocationApiDataSource locationApiDataSource;

  ///
  LocationLocalDataSource locationLocalDataSource;

  @override
  Future<Either<Failure, Coordinates>> getCoordinates() async {
    return _getCoordinates();
  }

  Future<Either<Failure, Coordinates>> _getCoordinates() async {
    try {
      final coordinates = await locationGpsDataSource.getCoordinates();
      return Right(coordinates);
    } on LocationException {
      try {
        final coordinates = await locationApiDataSource.getCoordinates();
        return Right(coordinates);
      } on NetworkException {
        return Left(NetworkFailure());
      } on ServerException {
        return Left(GetCoordinatesFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> saveLocationHistories(
    List<LocationHistory> locationHistories,
  ) async {
    await locationLocalDataSource.saveLocationHistories(
      locationHistories.map(LocationHistoryModel.fromEntity).toList(),
    );

    return const Right(true);
  }

  @override
  Either<Failure, List<LocationHistory>> getLocationHistories() {
    final locationHistories = locationLocalDataSource.getLocationHistories();
    return Right(locationHistories);
  }
}
