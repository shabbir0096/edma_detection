import 'package:edemadetection/screens/dashboard.dart';
import 'package:flutter/material.dart';

class DetectionsResult extends StatelessWidget {


  DetectionsResult();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detection Result"),
      ),
      body: const Center(
        child: Text("Screen 2 content"),
      ),
    );
  }
}
