import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/home/schedule_practice_controller.dart';

class OptionPoliScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SchedulePracticeController());
  }
}
