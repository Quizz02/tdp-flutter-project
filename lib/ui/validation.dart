import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdp_flutter_project/utils/utils.dart';

import 'homepage.dart';

class ValidationPage extends StatefulWidget {
  final user;
  const ValidationPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ValidationPage> createState() => _ValidationState();
}

class _ValidationState extends State<ValidationPage> {

  final confirmationCodeEditingController = new TextEditingController();

  confirmSignUp() async {
    SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: widget.user,
        confirmationCode: confirmationCodeEditingController.text
    );
    if (res.isSignUpComplete) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      showSnackbar('El código ingresado no es el correcto', context);
    }
  }

  @override
  Widget build(BuildContext context) {

    final confirmSignUpButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          confirmSignUp();
        },
        child: Text(
          "Confirmar registro",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Confirmación'),),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: "Ingresa tu código de verificación"),
              keyboardType: TextInputType.number,
              controller: confirmationCodeEditingController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 30,),
            confirmSignUpButton,
          ],
        ) ,
      ),
    );
  }
}
