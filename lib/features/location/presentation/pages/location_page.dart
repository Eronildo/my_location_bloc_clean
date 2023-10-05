import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../injection_container.dart';
import '../bloc/location_bloc.dart';
import '../widgets/google_map_widget.dart';
import '../widgets/location_history/bloc/location_history_bloc.dart';
import '../widgets/location_history/location_history_modal/location_history_modal_widget.dart';

/// The location page
///
/// Show a map and a pin of the user location.
class LocationPage extends StatefulWidget {
  /// A [LocationPage] constructor.
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final locationBloc = sl<LocationBloc>();
  final locationHistoryBloc = sl<LocationHistoryBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locationBloc),
        BlocProvider(create: (_) => locationHistoryBloc),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: [
                const GoogleMapWidget(),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        onPressed: () {
                          locationBloc.add(GetLocationCoordinates());
                        },
                        iconData: Icons.gps_fixed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: CustomButton(
              onPressed: showLocationHistoryList,
              iconData: Icons.history,
              label: context.i18n.lastLocations,
            ),
          );
        },
      ),
    );
  }

  /// Show a BottomSheet Modal with Locations History List Widget.
  void showLocationHistoryList() => showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => BlocProvider.value(
          value: locationBloc,
          child: BlocProvider.value(
            value: locationHistoryBloc,
            child: const LocationHistoryModalWidget(),
          ),
        ),
      );
}
