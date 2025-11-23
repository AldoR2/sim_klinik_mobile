import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/account/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}
