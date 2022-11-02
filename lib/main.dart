import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tdp_flutter_project/amplifyconfiguration.dart';
import 'package:tdp_flutter_project/models/ModelProvider.dart';
import 'package:tdp_flutter_project/providers/user_provider.dart';
import 'package:tdp_flutter_project/ui/login.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future<void> configureAmplify() async {
  final provider = ModelProvider();
  final dataStorePlugin = AmplifyDataStore(modelProvider: provider);

  Amplify.addPlugins([AmplifyAuthCognito(), dataStorePlugin]);
  Amplify.addPlugin(AmplifyAPI());
  //TODO: Add DataStore
  try{
    await Amplify.configure(amplifyconfig);
  }catch(e){
    print("Amplify is already configured");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const LoginScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Ocurrió un error interno'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

