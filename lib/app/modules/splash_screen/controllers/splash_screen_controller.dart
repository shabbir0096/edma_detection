import 'package:edemadetection/screens/onboarding_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../screens/dashboard.dart';
import '../../../services/firebase_services.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  final FirestoreService firestoreService = Get.put(FirestoreService());
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (user != null) {
        print("user is ${user}");
        Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashBoard(),
          ),
        );
      } else {
        Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnBoardingPage(),
          ),
        );
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    firestoreService.dispose();
  }
}
