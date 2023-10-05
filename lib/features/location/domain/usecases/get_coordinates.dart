import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/coordinates.dart';
import '../repositories/location_repository.dart';

///
class GetCoordinates implements UseCase<Coordinates, NoParams> {
  ///
  const GetCoordinates(this.repository);

  ///
  final LocationRepository repository;

  @override
  Future<Either<Failure, Coordinates>> call(NoParams _) async {
    return repository.getCoordinates();
  }
}
