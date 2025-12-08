import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/services/account/edit_profile_service.dart';

class EditProfileController extends GetxController {
  final GetStorage _box = GetStorage();
  final storedProfile = ''.obs;
  final Logger log = Logger();
  final statusPasien = ''.obs;
  final status = ''.obs;
  final username = ''.obs;
  final email = ''.obs;

  final EditProfileService editProfileService = EditProfileService();

  @override
  void onInit() {
    super.onInit();
    // checkingKIB();
    statusPasien.value = _box.read("status_pasien");
    email.value = _box.read("email");
    username.value = _box.read("username");
    log.d(statusPasien.value);
  }

  void showFileOptions() async {
    log.d("Pressed");
  }

  void checkingKIB() async {
    if (statusPasien.value == "tidakValid") {
      status.value = "KIB";
    } else {}
    status.value = "NON-KIB";
  }
}
