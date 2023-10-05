part of 'location_bloc.dart';

///
sealed class LocationEvent extends Equatable {
  ///
  const LocationEvent();

  @override
  List<Object> get props => [];
}

///
class GetLocationCoordinates extends LocationEvent {}

///
class GoToLocationCoordinates extends LocationEvent {
  ///
  const GoToLocationCoordinates({required this.coordinates});

  ///
  final Coordinates coordinates;

   @override
  List<Object> get props => [coordinates];
}
