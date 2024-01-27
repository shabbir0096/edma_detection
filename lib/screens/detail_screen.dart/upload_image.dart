import 'dart:io';

import 'package:edemadetection/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Screen1 extends StatefulWidget {
  final Items item;

  Screen1(this.item);

  @override
  State<Screen1> createState() => _Screen1State();
}



class _Screen1State extends State<Screen1> {


  File? imageFile;

  String? filename;
  Interpreter? interpreter;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    interpreter!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 96, 80, 117),
        appBar: AppBar(
          title: const Text("IMAGE-PICKER"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: const Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: const Text("TAKE PHOTO WITH CAMERA"),
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )));
  }



  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        filename = pickedFile.name;
      });
      await uploadImagetoFirebase(imageFile!);
    }
  }

  Future<void> uploadImagetoFirebase(File imageFile) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('image/')
          .child(filename!)
          .putFile(imageFile);
    } catch (e) {
      print(e);
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
