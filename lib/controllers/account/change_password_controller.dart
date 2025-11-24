import 'package:flutter/material.dart';
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
  final isSnackbarOpen = false.obs;

  final GetStorage _box = GetStorage();
  final Logger log = Logger();
  final email = "".obs;

  @override
  void onInit() {
    super.onInit();
    email.value = _box.read("email");
  }

  Future<void> submit() async {
    if (isSnackbarOpen.value == false) {
      final valid = await validation();
      if (valid) {
        changePassword();
      }
    }
  }

  Future<bool> validation() async {
    final currentPass = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass != confirmPass) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Gagal",
        "Password baru anda harus sesuai dengan konfirmasi password",
        duration: Duration(seconds: 2),
      );
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });
      return false;
    }

    if (newPass.length < 8) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Gagal",
        "Masukkan password baru lebih dari 8 karakter",
        duration: Duration(seconds: 2),
      );
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });
      return false;
    }

    try {
      showLoading();
      final result = await changePasswordService.checkPassword(
        email.value,
        currentPass,
      );

      if (result.status == "success") {
        return true;
      } else {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar(
          "Gagal",
          "Password sekarang tidak sesuai dengan yang terdaftar",
          duration: Duration(seconds: 2),
        );
        Future.delayed(Duration(seconds: 3), () {
          isSnackbarOpen.value = false;
        });
        return false;
      }
    } catch (e) {
      Get.back();
      log.e("Error: $e");
      isSnackbarOpen.value = true;
      Get.snackbar("Gagal", "Error: $e", duration: Duration(seconds: 2));
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });

      return false;
    }
  }

  void changePassword() async {
    try {
      final password = newPasswordController.text.trim();

      final result = await changePasswordService.changePassword(
        email.value,
        password,
      );
      if (result.status == "success") {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar(
          "Berhasil",
          "Password berhasil diubah, silahkan lakukan login ulang",
          duration: Duration(seconds: 2),
        );
        Future.delayed(Duration(seconds: 3), () {
          isSnackbarOpen.value = false;
        });
        Get.offAllNamed("/auth/login");
      } else {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar("Gagal", result.message, duration: Duration(seconds: 2));
        Future.delayed(Duration(seconds: 3), () {
          isSnackbarOpen.value = false;
        });
      }
    } catch (e) {
      Get.back();
      log.f("Gagal: $e");
      isSnackbarOpen.value = true;
      Get.snackbar("Gagal", "Error: $e", duration: Duration(seconds: 2));
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });
    }
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
