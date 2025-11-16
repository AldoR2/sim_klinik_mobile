import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/web.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';
import 'package:sim_klinik_mobile/services/auth/forget_password_service.dart';

class ForgetpasswordEmailController extends GetxController {
  final emailController = TextEditingController();

  final Logger log = Logger();
  final GetStorage _box = GetStorage();
  final ForgetPasswordService forgetPasswordService = ForgetPasswordService();

  final isSnackbarOpen = false.obs;
  final isLoading = false.obs;
  final delayedSnackbar = 1;

  void sendEmail() async {
    isLoading.value = true;

    final email = emailController.text.trim();

    if (!email.isEmail || email.isEmpty) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Error",
        "email tidak boleh kosong dan harus sesuai",
        duration: Duration(seconds: 1),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
      isLoading.value = false;
      return;
    }

    try {
      showLoading();
      final result = await forgetPasswordService.fetchEmail(email);

      if (result.status == "success") {
        Get.back();
        Get.toNamed("/auth/forgetPassword/verification", arguments: email);
        Get.snackbar(
          "Sukses",
          "Masukkan kode otp yang telah dikirim pada email pengguna",
        );
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
