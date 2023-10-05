import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/location_history_bloc.dart';
import 'location_history_widget.dart';

/// LocationHistoryList [Widget].
class LocationHistoryListWidget extends StatefulWidget {
  /// Create a [LocationHistoryListWidget].
  const LocationHistoryListWidget({super.key});

  @override
  State<LocationHistoryListWidget> createState() =>
      _LocationHistoryListWidgetState();
}

class _LocationHistoryListWidgetState extends State<LocationHistoryListWidget> {
  @override
  void initState() {
    BlocProvider.of<LocationHistoryBloc>(context).add(LoadLocationHistories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LocationHistoryBloc, LocationHistoryState>(
        builder: (context, state) {
          final histories = state.locationHistories;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: histories.length,
            itemBuilder: (context, index) => LocationHistoryWidget(
              locationHistory: histories[index],
            ),
          );
        },
      ),
    );
  }
}
