import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/base/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseController());
  }
}
