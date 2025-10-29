import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/auth/register_account_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterAccountController());
  }
}
