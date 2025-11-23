import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';
import 'package:sim_klinik_mobile/services/account/change_password_service.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ChangePasswordService changePasswordService = ChangePasswordService();

  final GetStorage _box = GetStorage();
  final Logger log = Logger();
  final email = "".obs;

  @override
  void onInit() {
    super.onInit();
    email.value = _box.read("email");
  }

  Future<void> validation() async {
    final currentPass = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass != confirmPass) {
      Get.snackbar(
        "Gagal",
        "Password baru anda harus sesuai dengan konfirmasi password",
      );
    }

    showLoading();

    final result = await changePasswordService.checkPassword(
      email.value,
      newPass,
    );

    if (result.status == "success") {
    } else {}

    try {} catch (e) {
      log.e("Error: $e");
    }
  }

  void changePassword() async {
    try {
      final password = newPasswordController.text.trim();

      final result = await changePasswordService.changePassword(
        email.value,
        password,
      );
    } catch (e) {}
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showLoading() {
    Get.dialog(
      const LoadingPopup(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
