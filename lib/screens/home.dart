import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    PickedFile? _image;

  //this is a code get image from Camera
  _imageFromCamera() async {
  final XFile? image = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 50,
  );
  if (image != null) {
    setState(() {
      _image = image as PickedFile;
    });
  }
}

_imageFromGallery() async {
  final XFile? image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
  );
  if (image != null) {
    setState(() {
      _image = image as PickedFile;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        heightFactor: 1.0,
        child: Container(
           decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey, Colors.deepPurple], // Replace with your desired gradient colors
        ),
          ),
           child: Column(
          children: [
            //this is a container that contain image
            //when user select image from Gallery or Camera
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: 350,
                height: 350,
                child: (_image != null)
                    ? Image.file(File(_image!.path),fit: BoxFit.cover,)
                    : const Icon(
                        Icons.image,
                        size: 350,
                        color: Colors.white60,
                      ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              //this is used to provide space between icons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //this widget is used to get image from
                //Camera
                IconButton(
                  icon: const Icon(Icons.camera_alt,size: 50,color: Colors.blueGrey,),
                  onPressed: () {
                    _imageFromCamera();
                  },
                ),
                //this widget is used to get image from
                //Gallery
                IconButton(
                  icon: const Icon(Icons.image,size: 50,color: Colors.blueGrey,),
                  onPressed: () {
                    _imageFromGallery();
                  },
                ),
              ],
            ),
            //this widget provide space in vertical
            const SizedBox(
              height: 30,
            ),
            //this is used to perform uploading task
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30, right: 30),
              //this is a button that has event to perform action
              child: ElevatedButton(
                child: const Text("Upload Image",style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                onPressed: () {
                  //upload method calling from here
                  _upload(_image!);
                },
              ),
            ),
          ],
        ),
      ),
        ));
  }
  
   void _upload(PickedFile file) {
     final bytes = File(file.path).readAsBytesSync();
  String img64 = base64Encode(bytes);
  print("Image length: ${img64.length}");
  }
}

    