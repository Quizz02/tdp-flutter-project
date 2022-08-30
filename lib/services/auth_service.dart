import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tdp_flutter_project/models/user.dart' as model;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }


  Future<String> signUpUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    // required Uint8List file,
  }) async {
    String res = "Ocurrió algún error";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty) {
        //registrar usuario
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        //añadir usuario a la bd

        model.User user = model.User(
          uid: cred.user!.uid,
          firstname: firstname,
          lastname: lastname,
          email: email,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Éxito";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'El correo no tiene un formato adecuado.';
      } else if (e.code == 'weak-password') {
        res = 'La contraseña es muy debil.';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Ocurrió un error';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Éxito";
      } else {
        res = "Porfavor llene todo los campos";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'El usuario no existe.';
      } else if (e.code == 'wrong-password') {
        res = 'La contraseña es incorrecta.';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
