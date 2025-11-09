import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_popup.dart';
import 'package:sim_klinik_mobile/services/auth/forget_password_service.dart';

class ForgetpasswordChangeController extends GetxController {
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  final Logger log = Logger();
  final GetStorage _box = GetStorage();
  final ForgetPasswordService forgetPasswordService = ForgetPasswordService();

  final isSnackbarOpen = false.obs;
  final isLoading = false.obs;
  final email = ''.obs;
  final delayedSnackbar = 1;
  final isButtonEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments;
    log.d("Email: ${email.value}");
  }

  Future<void> fetchEmail() async {
    final emaill = email.value;
    final password = passController.text.trim();
    final passwordConfirm = passController.text.trim();

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
    } catch ($e) {}
  }

  void showLoading() {
    Get.dialog(
      const LoadingPopup(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
