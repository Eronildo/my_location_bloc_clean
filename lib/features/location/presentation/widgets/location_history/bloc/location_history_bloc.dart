import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/location_history.dart';
import '../../../../domain/usecases/get_location_histories.dart';
import '../../../../domain/usecases/save_location_histories.dart';
import '../../../bloc/location_bloc.dart';

part 'location_history_event.dart';
part 'location_history_state.dart';

///
class LocationHistoryBloc
    extends Bloc<LocationHistoryEvent, LocationHistoryState> {
  ///
  LocationHistoryBloc({
    required this.locationBloc,
    required this.saveLocationHistories,
    required this.getLocationHistories,
  }) : super(const LocationHistoryState(locationHistories: [])) {
    on<LoadLocationHistories>(_loadLocationHistories);

    add(LoadLocationHistories());

    _locationBlocSubscription =
        locationBloc.stream.listen(_saveLocationHistories);
  }

  late StreamSubscription<LocationState> _locationBlocSubscription;

  ///
  final LocationBloc locationBloc;

  ///
  final SaveLocationHistories saveLocationHistories;

  ///
  final GetLocationHistories getLocationHistories;

  FutureOr<void> _loadLocationHistories(
    event,
    Emitter<LocationHistoryState> emit,
  ) async {
    final failureOrHistories = await getLocationHistories(NoParams());
    failureOrHistories.fold(
      (l) => null,
      (locationHistories) => emit(
        LocationHistoryState(locationHistories: locationHistories),
      ),
    );
  }

  void _saveLocationHistories(LocationState locationState) {
    if (locationState is Loaded) {
      final coordinates = locationState.coordinates;
      final historiesState = state.locationHistories;
      if (historiesState
          .where((element) => element.coordinates == coordinates)
          .isEmpty) {
        final locationHistory = LocationHistory(
          historyDate: DateTime.now(),
          coordinates: coordinates,
        );
        final newHistories = <LocationHistory>[
          ...historiesState,
          locationHistory,
        ]..sort((a, b) => b.historyDate.compareTo(a.historyDate));
        saveLocationHistories(
          Params(locationHistories: newHistories),
        );
      }
    }
  }

  ///
  @override
  Future<void> close() async {
    await _locationBlocSubscription.cancel();
    await super.close();
  }
}
