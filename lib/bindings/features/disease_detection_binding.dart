import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/home/disease_detection_controller.dart';

class DiseaseDetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DiseaseDetectionController());
  }
}
