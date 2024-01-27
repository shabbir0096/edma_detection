

import 'package:edemadetection/app/modules/doctors_page/controllers/doctors_page_controller.dart';

import '../app_export.dart';
import '../network/network_info.dart';
import 'pref_utils.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    Get.put(DoctorsPageController());
  }
}