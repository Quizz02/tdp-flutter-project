import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-11.960141, -77.075963),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
    target: LatLng(-11.960141, -77.075963),
    // tilt: 59.440717697143555,
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // appBar: AppBar(title: Text('Probabilidad')),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          )
        },
      ),
    );
  }

  Future<void> goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
