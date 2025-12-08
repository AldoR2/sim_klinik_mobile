import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class BaseController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();
  final statusPasien = ''.obs;

  @override
  void onInit() {
    super.onInit();
    statusPasien.value = _box.read("status_pasien");
  }

  void bookForm() async {
    if (statusPasien.value == "tidakValid") {
      Get.snackbar("Gagal", "Lakukan pembuatan KIB terlebih dahulu");
    } else {
      Get.toNamed('/booking_form');
    }
  }
}
