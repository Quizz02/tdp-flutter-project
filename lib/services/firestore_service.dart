import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tdp_flutter_project/models/report.dart';
import 'package:tdp_flutter_project/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //subir reporte
  Future<String> uploadReport(
      String description,
      Uint8List file,
      String uid,
      String firstname,
      String lastname,
      String reference,
      String category,
      String latitude,
      String longitude,
      ) async {
    String res = "Ocurrió un error";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage('reports', file, true);

      String reportId = const Uuid().v1();

      Report report = Report(
        description: description,
        uid: uid,
        firstname: firstname,
        lastname: lastname,
        reportId: reportId,
        reportUrl: photoUrl,
        reference: reference,
        category: category,
        likes: [],
        latitude: latitude,
        longitude: longitude,
      );

      _firestore.collection('reports').doc(reportId).set(report.toJson(),);
      res = "Éxito";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
