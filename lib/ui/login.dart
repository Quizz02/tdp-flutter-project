import 'package:flutter/material.dart';
import 'package:tdp_flutter_project/main.dart';
import 'package:tdp_flutter_project/ui/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //validator: () {}

      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Correo electrónico",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      //validator: () {}

      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Contraseña",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final loginButton = Material(
      // elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
        child: Text(
          "Iniciar Sesión",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                      child: Image.asset(
                        "assets/LOGO.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    emailField,
                    SizedBox(
                      height: 30,
                    ),
                    passwordField,
                    SizedBox(
                      height: 30,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿No tienes una cuenta? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => RegistrationScreen()));
                          },
                          child: Text(
                            "Regístrate",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
