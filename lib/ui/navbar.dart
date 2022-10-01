import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tdp_flutter_project/providers/user_provider.dart';
import 'package:tdp_flutter_project/services/auth_service.dart';
import 'package:tdp_flutter_project/ui/comunity_feed.dart';
import 'package:tdp_flutter_project/ui/incident_report.dart';
import 'package:tdp_flutter_project/ui/login.dart';
import 'package:tdp_flutter_project/ui/my_reports.dart';
import 'package:tdp_flutter_project/ui/probability.dart';
import 'package:tdp_flutter_project/models/user.dart' as model;

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String username = "";
  String email = "";
  late Position camPosition;
  late bool serviceEnabled;
  var location = new Location();


  _determinePosition() async {
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
    setState((){
      camPosition = position;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.firstname + ' ' + user.lastname),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                    'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                    color: Colors.grey,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.house),
            title: Text('Inicio'),
            onTap: () => print('Inicio!!'),
          ),
          ListTile(
              leading: Icon(Icons.groups),
              title: Text('Comunidad'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ComunityFeed()));
              }),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Mis Reportes'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyReports(user: user,)));
              }),
          ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Probabilidad'),
              onTap: () async {
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                  if (!serviceEnabled) {
                    return;
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Probability()));
              }),
          ListTile(
              leading: Icon(Icons.warning),
              title: Text('Reportar Incidente'),
              onTap: () async {
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                  if (!serviceEnabled) {
                    return;
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => IncidentReport(
                              position: camPosition,
                            )));
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () => print('Configuración'),
          ),
          ListTile(
            leading: Icon(Icons.sensor_door_outlined),
            title: Text('Cerrar Sesión'),
            onTap: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
