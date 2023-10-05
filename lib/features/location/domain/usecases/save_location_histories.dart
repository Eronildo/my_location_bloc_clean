import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_history.dart';
import '../repositories/location_repository.dart';

///
class SaveLocationHistories implements UseCase<bool, Params> {
  ///
  const SaveLocationHistories(this.repository);

  ///
  final LocationRepository repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return repository.saveLocationHistories(params.locationHistories);
  }
}

///
class Params extends Equatable {
  ///
  const Params({required this.locationHistories});

  ///
  final List<LocationHistory> locationHistories;

  @override
  List<Object> get props => [locationHistories];
}
