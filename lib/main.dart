import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tdp_flutter_project/ui/login.dart';
import 'package:tdp_flutter_project/ui/navbar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if (snapshot.hasData) {
              return const MyHomePage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Ocurrió un error interno'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text('Inicio')),
      body: Center(),
    );
  }
}
