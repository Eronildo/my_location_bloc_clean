import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/date_time_extension.dart';
import '../../../domain/entities/location_history.dart';
import '../../bloc/location_bloc.dart';

/// A unit [LocationHistory] widget.
class LocationHistoryWidget extends StatelessWidget {
  /// Create a [LocationHistoryWidget].
  const LocationHistoryWidget({
    required this.locationHistory,
    super.key,
  });

  /// A [LocationHistory] model.
  final LocationHistory locationHistory;

  @override
  Widget build(BuildContext context) {
    final localeCode = Localizations.localeOf(context).languageCode;
    return ListTile(
      title: Text(
        locationHistory.historyDate.format(localeCode: localeCode),
      ),
      trailing: IconButton(
        onPressed: () {
          BlocProvider.of<LocationBloc>(context).add(
            GoToLocationCoordinates(coordinates: locationHistory.coordinates),
          );
          Navigator.pop(context);
        },
        icon: const Icon(Icons.location_pin),
      ),
    );
  }
}
