import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String uid;
  final String firstname;
  final String lastname;
  final String reportId;
  final String description;
  final String reference;
  // final String photoUrl;
  final String category;
  // final String time;
  final String reportUrl;
  final likes;

  const Report({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.reportId,
    required this.description,
    required this.reference,
    // required this.photoUrl,
    required this.category,
    // required this.time,
    required this.reportUrl,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'reportId': reportId,
        'description': description,
        'reference': reference,
        // 'photoUrl': photoUrl,
        'category': category,
        'reportUrl': reportUrl,
        'likes': likes,
      };

  static Report fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Report(
      uid: snapshot['uid'],
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      reportId: snapshot['reportId'],
      description: snapshot['description'],
      reference: snapshot['reference'],
      // photoUrl: snapshot['photoUrl'],
      category: snapshot['category'],
      reportUrl: snapshot['reportUrl'],
      likes: snapshot['likes'],
    );
  }
}
