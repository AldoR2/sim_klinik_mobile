import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/auth/register_account_verification_controller.dart';

class RegisterAccountVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterAccountVerificationController());
  }
}
