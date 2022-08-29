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
}
