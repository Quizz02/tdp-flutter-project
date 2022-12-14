import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdp_flutter_project/services/auth_service.dart';
import 'package:tdp_flutter_project/ui/validation.dart';
import '../main.dart';
import '../utils/utils.dart';
import 'homepage.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool formFlag = false;
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  void signUpUser() async {
    try {
    await Amplify.Auth.signUp(
      username: emailEditingController.text,
      password: passwordEditingController.text,
      options: CognitoSignUpOptions(
        userAttributes: {
          CognitoUserAttributeKey.email: emailEditingController.text
        },
      ),
    );

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ValidationPage(user: emailEditingController.text)));

    await AuthMethods().signUpUser(
        email: emailEditingController.text,
        password: passwordEditingController.text,
        firstname: firstNameEditingController.text,
        lastname: lastNameEditingController.text);
    // if (res != 'Éxito') {
    //   showSnackbar(res, context);
    // }
    }
    catch (e) {
      showSnackbar('La contraseña debe contener letras minusculas, mayusculas y un caracter especial', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? validatePassword(String value) {
      if (value.length < 6 && value.isNotEmpty) {
        return "La contraseña debe 6 caracteres o más";
      }
      return null;
    }

    String? validateField(String value) {
      if ((!(value.contains('@')) || !(value.contains('.'))) && value.isNotEmpty) {
        return "El correo no tiene un formato adecuado";
      }
      return null;
    }

    String? confirmPassword(String value, String passwordController) {
      if (value != passwordController && value.isNotEmpty) {
        return "Las contraseñas no coinciden";
      }
      return null;
    }

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
      ],
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle_rounded),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Nombres",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
      ],
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle_rounded),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Apellidos",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9_.@]")),
      ],
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Correo electrónico",
        errorText: validateField(emailEditingController.text),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Contraseña",
        errorText: validatePassword(passwordEditingController.text),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      //validator: () {}

      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Repetir contraseña",
        errorText: confirmPassword(confirmPasswordEditingController.text, passwordEditingController.text),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final signUpButton = Material(
      // elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async => signUpUser(),
        child: Text(
          "Regístrate",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
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
                    firstNameField,
                    SizedBox(
                      height: 30,
                    ),
                    lastNameField,
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
                    confirmPasswordField,
                    SizedBox(
                      height: 30,
                    ),
                    signUpButton,
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
