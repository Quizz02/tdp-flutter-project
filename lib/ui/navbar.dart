import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdp_flutter_project/providers/user_provider.dart';
import 'package:tdp_flutter_project/ui/comunity_feed.dart';
import 'package:tdp_flutter_project/ui/incident_report.dart';
import 'package:tdp_flutter_project/ui/probability.dart';
import 'package:tdp_flutter_project/models/user.dart' as model;

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String username = "";
  String email = "";

  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  // }
  //
  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState((){
  //     username = (snap.data() as Map<String, dynamic>)['firstname'] + ' ' + (snap.data() as Map<String, dynamic>)['lastname'];
  //     email = (snap.data() as Map<String, dynamic>)['email'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    model.User user =  Provider.of<UserProvider>(context).getUser;
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
            leading: Icon(Icons.insert_chart_rounded),
            title: Text('Resumen Semanal'),
            onTap: () => print('Resumen'),
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
              onTap: () => print('Reportes')),
          ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Probabilidad'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Probability()));
              }),
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
