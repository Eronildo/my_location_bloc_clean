part of 'location_history_bloc.dart';

///
sealed class LocationHistoryEvent extends Equatable {
  ///
  const LocationHistoryEvent();

  @override
  List<Object> get props => [];
}

///
class LoadLocationHistories extends LocationHistoryEvent {}
