import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String?> uploadFile(File file) async {
    try {
      // Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref();

      // Use the file's name as the storage reference path
      String fileName = basename(file.path);
      final fileRef = storageRef.child('foodImages/$fileName');

      // Upload the file
      UploadTask uploadTask = fileRef.putFile(file);

      // Await the upload completion
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}
