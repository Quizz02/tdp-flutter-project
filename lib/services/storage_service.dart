import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

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

  // Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) {
  //   _storage.ref().child(childName).child(path)
  // }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await _storage.ref('text').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('found file: $ref');
     });
    
    return results;
  }

}
