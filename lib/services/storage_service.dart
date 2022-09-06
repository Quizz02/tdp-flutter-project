import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:uuid/uuid.dart';

class StorageMethods {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadFile(
    String filepath,
    String fileName,
  ) async {
    File file = File(filepath);

    try {
      await _storage.ref('images/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    firebase_storage.Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost){
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    firebase_storage.UploadTask uploadTask = ref.putData(file);

    firebase_storage.TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await _storage.ref('text').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('found file: $ref');
     });
    
    return results;
  }

}
