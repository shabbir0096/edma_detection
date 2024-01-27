import 'package:get/get.dart';

import '../controllers/doctors_page_controller.dart';

class DoctorsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsPageController>(
      () => DoctorsPageController(),
    );
  }
}
