import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/base/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
