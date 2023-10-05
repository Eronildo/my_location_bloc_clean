part of 'location_bloc.dart';

///
sealed class LocationState extends Equatable {
  ///
  const LocationState();

  @override
  List<Object> get props => [];
}

///
class Initial extends LocationState {}

///
class Loaded extends LocationState {
  ///
  const Loaded({required this.coordinates});

  ///
  final Coordinates coordinates;

  @override
  List<Object> get props => [coordinates];
}

///
class Error extends LocationState {
  ///
  const Error({required this.failure});

  ///
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
