import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String firstname;
  final String lastname;

  const User({
    required this.email,
    required this.uid,
    required this.firstname,
    required this.lastname,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    
    return User(
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}
