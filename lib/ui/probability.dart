import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/map_widget.dart';

class Probability extends StatefulWidget {
  final snap;
  const Probability({Key? key, required this.snap}) : super(key: key);

  @override
  State<Probability> createState() => _ProbabilityState();
}

class _ProbabilityState extends State<Probability> {
  late GoogleMapController googleMapController;
  List<Marker> markers = [];

  static const CameraPosition initialCamPosition = CameraPosition(
    target: LatLng(-11.960141, -77.075963),
    zoom: 14,
  );

  AddMarker() async {
    Position position = await _determinePosition();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 18)));

    // markers.clear();
    //
    // markers.add(Marker(
    //     markerId: const MarkerId('currentLocation'),
    //     icon: BitmapDescriptor.defaultMarker,
    //     position: LatLng(position.latitude, position.longitude)));

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Probabilidad')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('reports').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              final snap = snapshot.data!.docs[i].data();
              Marker tempMarker = Marker(
                  markerId: MarkerId(snap['reportId']),
                  position: LatLng(double.parse(snap['latitude']), double.parse(snap['longitude'])));
              if(markers.contains(tempMarker)){
                continue;
              }
              markers.add(Marker(
                markerId: MarkerId(snap['reportId']),
                position: LatLng(double.parse(snap['latitude']), double.parse(snap['longitude'])),
              ));
            }
            return Center(
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
                          markers: Set<Marker>.of(markers),
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
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
            );
          }),
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
