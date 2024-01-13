import 'package:edemadetection/app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_image_view.dart';
import '../controllers/splash_screen_controller.dart';

// ignore_for_file: must_be_immutable
class SplashScreen extends GetWidget<SplashScreenController> {
  const SplashScreen({Key? key})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.maxFinite,
            height: Get.height*.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                CustomImageView(
                  imagePath: ImageConstant.appLogo,
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}