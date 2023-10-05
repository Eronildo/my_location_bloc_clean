import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/coordinates.dart';
import '../entities/location_history.dart';

///
abstract class LocationRepository {
  ///
  Future<Either<Failure, Coordinates>> getCoordinates();

  ///
  Future<Either<Failure, bool>> saveLocationHistories(
    List<LocationHistory> locationHistories,
  );

  ///
  Either<Failure, List<LocationHistory>> getLocationHistories();
}
