import 'package:get/get.dart';

import '../../../services/firebase_services.dart';
import '../model/doctors_model.dart';

class DoctorsPageController extends GetxController {
  List<Doctor> doctors = [];
  Future<void> fetchData() async {
    FirestoreService doctorService = FirestoreService();

    try {
      doctors = await doctorService.getDoctors();
      print("Doctors $doctors");
    } catch (e) {
      print('Error fetching doctors: $e');
      // Handle error if needed
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchData();
    super.onInit();
  }
}
