import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/home/medical_history_controller.dart';

class MedicalHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MedicalHistoryController());
  }
}
