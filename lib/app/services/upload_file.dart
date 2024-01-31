import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class UploadResult {
  final double progress;
  final String downloadURL;

  UploadResult(this.progress, this.downloadURL);
}

Future<UploadResult> uploadFile(String refName, String fileName, String filePath) async {
  try {
    final Reference ref = firebase_storage.FirebaseStorage.instance.ref(refName).child(fileName);
    final UploadTask uploadTask = ref.putFile(File(filePath));



    final uploadSnapshot = await uploadTask;

    final downloadURL = await ref.getDownloadURL();

    final progress = uploadSnapshot.bytesTransferred / uploadSnapshot.totalBytes;
    return UploadResult(progress, downloadURL);
  } catch (e) {
    print('Error uploading file: $e');
    rethrow; // Rethrow the exception to let the caller handle it
  }

}
