import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/auth/forgetPassword_verification_controller.dart';

class ForgetPasswordVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetpasswordVerificationController());
  }
}
