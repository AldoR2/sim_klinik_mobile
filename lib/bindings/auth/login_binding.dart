import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
