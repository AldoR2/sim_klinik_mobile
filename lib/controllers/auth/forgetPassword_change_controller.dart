import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';
import 'package:sim_klinik_mobile/services/auth/forget_password_service.dart';

class ForgetpasswordChangeController extends GetxController {
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  final Logger log = Logger();
  final GetStorage _box = GetStorage();
  final ForgetPasswordService forgetPasswordService = ForgetPasswordService();

  final isPasswordVisible = false.obs;
  final isPasswordConfirmVisible = false.obs;

  final isSnackbarOpen = false.obs;
  final isLoading = false.obs;
  final email = ''.obs;
  final delayedSnackbar = 1;
  final isButtonEnabled = true.obs;

  void checkVisible() => isPasswordVisible.toggle();
  void checkConfirmVisible() => isPasswordConfirmVisible.toggle();

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments;
    log.d("Email: ${email.value}");
  }

  Future<void> changePass() async {
    final emaill = email.value;
    final password = passController.text.trim();
    final passwordConfirm = passConfirmController.text.trim();

    if (password != passwordConfirm) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Error",
        "Password harus sesuai dengan konfirmasi password",
        duration: Duration(seconds: delayedSnackbar),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
      return;
    }

    try {
      showLoading();
      final result = await forgetPasswordService.fetchPassword(
        emaill,
        password,
      );

      if (result.status == "success") {
        Get.back();
        Get.snackbar("Sukses", "Password berhasil diperbarui");
        Get.offAllNamed("/auth/login");
      } else {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar("Gagal", result.message, duration: Duration(seconds: 2));
        Future.delayed(Duration(seconds: 3), () {
          isSnackbarOpen.value = false;
        });
      }

      isLoading.value = false;
    } catch (e) {
      Get.back();
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Error",
        e.toString(),
        duration: Duration(seconds: delayedSnackbar),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
    }
  }

  void showLoading() {
    Get.dialog(
      const LoadingPopup(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
