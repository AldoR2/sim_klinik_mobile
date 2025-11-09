import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/auth/forgetPassword_email_controller.dart';

class ForgetPasswordEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetpasswordEmailController());
  }
}
