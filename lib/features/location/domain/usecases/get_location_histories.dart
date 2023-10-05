import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_history.dart';
import '../repositories/location_repository.dart';

///
class GetLocationHistories implements UseCase<List<LocationHistory>, NoParams> {
  ///
  const GetLocationHistories(this.repository);

  ///
  final LocationRepository repository;

  @override
  Future<Either<Failure, List<LocationHistory>>> call(NoParams _) async {
    return repository.getLocationHistories();
  }
}
