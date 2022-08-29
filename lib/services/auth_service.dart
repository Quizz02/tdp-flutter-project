import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    // required Uint8List file,
  }) async {
    String res = "Ocurrió algún error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || firstname.isNotEmpty || lastname.isNotEmpty) {
        //registrar usuario
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(cred.user!.uid);
        //añadir usuario a la bd
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'uid' : cred.user!.uid,
          'firstname' : firstname,
          'lastname' : lastname,
          'email' : email,
        });
        res = "Éxito";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}