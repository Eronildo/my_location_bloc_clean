import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/coordinates.dart';
import '../../domain/usecases/get_coordinates.dart';

part 'location_event.dart';
part 'location_state.dart';

///
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  ///
  LocationBloc({required this.getCoordinates}) : super(Initial()) {
    on<GetLocationCoordinates>(_getLocationCoordinates);
    on<GoToLocationCoordinates>(_goToLocationCoordinates);
    add(GetLocationCoordinates());
  }

  ///
  final GetCoordinates getCoordinates;

  FutureOr<void> _getLocationCoordinates(_, Emitter<LocationState> emit) async {
    final failureOrCoordinates = await getCoordinates(NoParams());
    emit(_eitherLoadedOrErrorState(failureOrCoordinates));
  }

  void _goToLocationCoordinates(
    GoToLocationCoordinates event,
    Emitter<LocationState> emit,
  ) {
    emit(Loaded(coordinates: event.coordinates));
  }

  LocationState _eitherLoadedOrErrorState(
    Either<Failure, Coordinates> failureOrCoordinates,
  ) {
    return failureOrCoordinates.fold<LocationState>(
      (failure) => Error(failure: failure),
      (coordinates) => Loaded(coordinates: coordinates),
    );
  }
}
