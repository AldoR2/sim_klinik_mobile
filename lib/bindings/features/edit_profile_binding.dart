import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/account/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}
