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
import 'package:http/http.dart';
import 'package:tdp_flutter_project/models/ReportPrediction.dart';
import '../widgets/map_widget.dart';
import 'package:http/http.dart' as http;

class Probability extends StatefulWidget {
  @override
  State<Probability> createState() => _ProbabilityState();
}

class _ProbabilityState extends State<Probability> {

  late Future<List<ReportPrediction>> _listadoReportes;
  late GoogleMapController googleMapController;
  List<Marker> markers = [];
  CollectionReference reportsref =
      FirebaseFirestore.instance.collection("reports");
  var robo = 0.00;
  var roboAgravado = 0.00;
  var hurto = 0.00;
  var hurtoAgravado = 0.00;
  var homicidio = 0.00;
  var microcomercializacion = 0.00;
  bool isLoading = false;
  List predictionList = [];

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

  Future<List<ReportPrediction>> _getReportes() async {
    var url = Uri.parse("https://fastapi-production-2d89.up.railway.app/prediction");
    final response = await http.get(url);
    var lastPrediction = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        predictionList = lastPrediction;
        robo = double.parse(predictionList[predictionList.length-1]["robo"]) * 100;
        roboAgravado = double.parse(predictionList[predictionList.length-1]["robo agravado"]) * 100;
        hurto = double.parse(predictionList[predictionList.length-1]["hurto"]) * 100;
        hurtoAgravado = double.parse(predictionList[predictionList.length-1]["hurto agravado"]) * 100;
        homicidio = double.parse(predictionList[predictionList.length-1]["homicidio calificado - asesinato"]) * 100;
        microcomercializacion = double.parse(predictionList[predictionList.length-1]["microcomercializacion de drogas"]) * 100;
      });
      print('Success');
    } else {
      throw Exception("Connection Failed");
    }
    throw Exception("Connection Made");
  }

  filterAll() {
    setState(() {
      isLoading = true;
    });
    _getReportes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // _getReportes();
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
                                Text('Robo: $robo %',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text('Robo Agravado: $roboAgravado %',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text('Hurto: $hurto %',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text('Hurto Agravado: $hurtoAgravado %',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text(
                                    'Homicidio Calificado - Asesinato: $homicidio %',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 10),
                                Text(
                                    'Microcomercializacion de Drogas: $microcomercializacion %',
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
