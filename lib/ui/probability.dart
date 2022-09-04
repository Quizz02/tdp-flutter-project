import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/map_widget.dart';

class Probability extends StatefulWidget {
  @override
  State<Probability> createState() => _ProbabilityState();
}

class _ProbabilityState extends State<Probability> {
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  static const CameraPosition initialCamPosition = CameraPosition(
    target: LatLng(-11.960141, -77.075963),
    zoom: 14,
  );

  AddMarker() async{
    Position position = await _determinePosition();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18)));

    markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(position.latitude, position.longitude)));

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Probabilidad')),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 400,
              width: 400,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GoogleMap(
                    initialCameraPosition: initialCamPosition,
                    mapType: MapType.normal,
                    markers: markers,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      googleMapController = controller;
                    },
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      )
                    },
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AddMarker();
        },
        label: Text('Ubicación Actual'),
        icon: Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Permiso de ubicación denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Los permisos de ubicación han sido permanentemente denegados');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
