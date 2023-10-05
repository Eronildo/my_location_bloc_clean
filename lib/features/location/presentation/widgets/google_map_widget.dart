import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../domain/entities/coordinates.dart';
import '../bloc/location_bloc.dart';

/// Wrapper of [GoogleMap] Widget.
class GoogleMapWidget extends StatefulWidget {
  /// [GoogleMapWidget] constructor.
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final _googleControllerCompleter = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) async {
        if (state is Loaded) {
          final controller = await _googleControllerCompleter.future;
          await controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  state.coordinates.latitude,
                  state.coordinates.longitude,
                ),
                zoom: 20,
              ),
            ),
          );
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_mapFailureToMessage(state.failure))),
          );
        }
      },
      builder: (context, state) => switch (state) {
        Loaded() => _getGoogleMap(state.coordinates),
        _ => _getGoogleMap(Coordinates.empty()),
      },
    );
  }

  GoogleMap _getGoogleMap(Coordinates coordinates) => GoogleMap(
        initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
        onMapCreated: _googleControllerCompleter.complete,
        markers: {
          if (coordinates != Coordinates.empty())
            Marker(
              markerId: const MarkerId('user'),
              position: LatLng(
                coordinates.latitude,
                coordinates.longitude,
              ),
            ),
        },
      );

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case GetCoordinatesFailure:
        return context.i18n.getCoordinatesError;
      case NetworkFailure:
        return context.i18n.noConnection;
      default:
        return context.i18n.unexpectedError;
    }
  }
}
