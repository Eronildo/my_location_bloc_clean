part of 'location_history_bloc.dart';

///
class LocationHistoryState extends Equatable {
  ///
  const LocationHistoryState({required this.locationHistories});

  ///
  final List<LocationHistory> locationHistories;

  @override
  List<Object> get props => [];
}
