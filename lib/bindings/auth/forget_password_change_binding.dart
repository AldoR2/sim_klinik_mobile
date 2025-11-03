import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/auth/forget_password_change_controller.dart';

class ForgetpasswordChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetpasswordChangeController());
  }
}
