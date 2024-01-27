import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../modules/doctors_page/model/doctors_model.dart';
import '../widgets/snackbars.dart';

class FirestoreService extends GetxController {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _detectedResultCollection =
  FirebaseFirestore.instance.collection('detected_result');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  // final UploadController controller = Get.put(UploadController());
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // RxList to store the list of documents
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> userList =
      RxList<QueryDocumentSnapshot<Map<String, dynamic>>>();

  // Function to fetch all documents from the collection
  void fetchAllUsers() {
    _usersCollection.get().then((querySnapshot) {
      userList.value = querySnapshot.docs
          .map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>)
          .toList();
    });
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  bool get isLoggedIn => firebaseUser.value != null;

  Future<List<DocumentSnapshot>> getUsers() async {
    QuerySnapshot snapshot = await _usersCollection.get();
    return snapshot.docs;
  }

  Future<DocumentSnapshot> getUserById(String userId) async {
    return _usersCollection.doc(userId).get();
  }

  String? getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;
    return userId;
  }

  void signOut() async {
    await _auth.signOut();
  }

  void updateCompleteProfile(double profileCompleteValue) {
    DocumentReference documentRef = _usersCollection.doc(getCurrentUserId());
    documentRef.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        double currentValue = data['profile_complete'] ?? 0.0;
        if (kDebugMode) {
          print(profileCompleteValue);
        }
        double incrementedValue = currentValue + profileCompleteValue;

        documentRef
            .update({'profile_complete': incrementedValue})
            .then((value) => print("Document updated successfully."))
            .catchError((error) => print("Failed to update document: $error"));
      } else {}
    }).catchError((error) => print("Failed to retrieve document: $error"));
  }

  void updateUserDisplayName(String displayName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(displayName);
        if (kDebugMode) {
          print('Display Name updated successfully');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to update Display Name: $e');
        }
      }
    } else {
      if (kDebugMode) {
        print('User is not signed in');
      }
    }
  }




  Future<Stream<double>> uploadFileToStorageWithProgress(
      File file, String storagePath) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute.path}/$storagePath";
    final file = File(filePath);

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

    // Create a reference to the Firebase Storage bucket
    final storageRef = _storage.ref().child(storagePath);

    final uploadTask = storageRef.putFile(file, metadata);

    StreamController<double> progressStreamController =
        StreamController<double>();

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // ...
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          progressStreamController.add(progress);
          break;
        case TaskState.paused:
          // ...
          break;
        case TaskState.success:
          // ...
          progressStreamController.close();
          break;
        case TaskState.canceled:
          // ...
          break;
        case TaskState.error:
          // ...
          break;
      }
    }, onDone: () {
      progressStreamController.close();
    });

    return progressStreamController.stream;
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Doctor>> getDoctors() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('doctors').get();
      return snapshot.docs.map((doc) => Doctor.fromFirestore(doc.data())).toList();
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }

}
