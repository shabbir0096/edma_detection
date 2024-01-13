import 'package:edemadetection/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
     Get.offAndToNamed(AppRoutes.onBoardingRoute);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
