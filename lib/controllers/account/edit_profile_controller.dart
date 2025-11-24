import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/services/account/edit_profile_service.dart';

class EditProfileController extends GetxController {
  final storedProfile = ''.obs;
  final Logger log = Logger();

  final EditProfileService editProfileService = EditProfileService();

  void showFileOptions() async {
    log.d("Pressed");
  }
}
