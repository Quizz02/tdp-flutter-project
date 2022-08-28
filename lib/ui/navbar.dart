import 'package:flutter/material.dart';
import 'package:tdp_flutter_project/ui/incident_report.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Matías Beteta'),
            accountEmail: Text('amir_9_2011@hotmail.com'),
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
            leading: Icon(Icons.insert_chart_rounded),
            title: Text('Resumen Semanal'),
            onTap: () => print('Resumen'),
          ),
          ListTile(
            leading: Icon(Icons.groups),
            title: Text('Comunidad'),
            onTap: () => print('Comunidad'),
          ),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Mis Reportes'),
              onTap: () => print('Reportes')),
          ListTile(
            leading: Icon(Icons.notification_important),
            title: Text('Probabilidad'),
            onTap: () => print('Probabilidad'),
          ),
          ListTile(
              leading: Icon(Icons.warning),
              title: Text('Reportar Incidente'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => IncidentReport()));
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () => print('Configuración'),
          ),
        ],
      ),
    );
  }
}
