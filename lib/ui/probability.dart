import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Marker> markers = [];
  CollectionReference reportsref =
      FirebaseFirestore.instance.collection("reports");
  var robo = 0;
  var roboAgravado = 0;
  var hurto = 0;
  var hurtoAgravado = 0;
  var homicidio = 0;
  var microcomercializacion = 0;
  bool isLoading = false;

  static const CameraPosition initialCamPosition = CameraPosition(
    target: LatLng(-11.960141, -77.075963),
    zoom: 14,
  );

  AddMarker() async {
    Position position = await _determinePosition();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 18)));

    setState(() {});
  }

  filterDataByRobo() async {
    int count = 0;
    await reportsref.where("category", isEqualTo: "Robo").get().then((value) {
      // if (!mounted) {
      //   return;
      // }
      value.docs.forEach((element) {
        count += 1;
        print(element.data());
      });
      setState(() {
        robo = count;
      });
    });

  }

  filterDataByRoboAgravado() async {
    int count = 0;
    await reportsref
        .where("category", isEqualTo: "Robo Agravado")
        .get()
        .then((value) {
      // if (!mounted) {
      //   return;
      // }
      value.docs.forEach((element) {
        count += 1;
        print(element.data());
      });
      setState(() {
        roboAgravado = count;
      });
    });

  }

  filterDataByHurto() async {
    int count = 0;
    await reportsref.where("category", isEqualTo: "Hurto").get().then((value) {
      // if (!mounted) {
      //   return;
      // }
      value.docs.forEach((element) {
        count += 1;
        print(element.data());
      });
      setState(() {
        hurto = count;
      });
    });

  }

  filterDataByHurtoAgravado() async {
    int count = 0;
    await reportsref
        .where("category", isEqualTo: "Hurto Agravado")
        .get()
        .then((value) {
      // if (!mounted) {
      //   return;
      // }
      value.docs.forEach((element) {
        count += 1;
        print(element.data());
      });
      setState(() {
        hurtoAgravado = count;
      });
    });

  }

  filterDataByHomicidio() async {
    int count = 0;
    await reportsref
        .where("category", isEqualTo: "Homicidio Calificado")
        .get()
        .then((value) {
      // if (!mounted) {
      //   return;
      // }
      value.docs.forEach((element) {
        count += 1;
        print(element.data());
      });
      setState(() {
        homicidio = count;
      });
    });

  }

  filterDataByMicrocomercializacion() async {
    int count = 0;
    await reportsref
        .where("category", isEqualTo: "Microcomercializacion de drogas")
        .get()
        .then((value) {
      // if (!mounted) {
      //   return;
      // }
      value.docs.forEach((element) {
        count += 1;
        print(element.data());
      });
      setState(() {
        microcomercializacion = count;
      });
    });
  }

  filterAll() {
    setState(() {
      isLoading = true;
    });
    filterDataByRobo();
    filterDataByRoboAgravado();
    filterDataByHurto();
    filterDataByHurtoAgravado();
    filterDataByHomicidio();
    filterDataByMicrocomercializacion();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    filterAll();
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
                  position: LatLng(double.parse(snap['latitude']),
                      double.parse(snap['longitude'])));
              if (markers.contains(tempMarker)) {
                continue;
              }
              markers.add(Marker(
                markerId: MarkerId(snap['reportId']),
                position: LatLng(double.parse(snap['latitude']),
                    double.parse(snap['longitude'])),
              ));
            }
            return Center(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : SingleChildScrollView(
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
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    googleMapController = controller;
                                  },
                                  gestureRecognizers: {
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    )
                                  },
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Número total de Reportes: ' +
                                      snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Categorias',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Robo: $robo',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text('Robo Agravado: $roboAgravado',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text('Hurto: $hurto',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text('Hurto Agravado: $hurtoAgravado',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text(
                                    'Homicidio Calificado - Asesinato: $homicidio',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text(
                                    'Microcomercializacion de Drogas: $microcomercializacion',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
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

  @override
  void dispose() {
    super.dispose();
  }
}
