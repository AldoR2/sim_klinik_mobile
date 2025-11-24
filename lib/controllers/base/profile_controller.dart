import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class ProfileController extends GetxController {
  final Logger log = Logger();
  final GetStorage _box = GetStorage();
  var data = {}.obs;

  @override
  void onInit() {
    super.onInit();
    final username = _box.read("username");
    final email = _box.read("email");
    data.addAll({"username": username, "email": email});
  }

  void logout() {
    _box.erase();
    Get.offAllNamed("/auth/login");
    Get.snackbar("Berhasil", "Logout telah berhasil");
  }
}
