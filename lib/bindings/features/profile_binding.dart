import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/base/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
