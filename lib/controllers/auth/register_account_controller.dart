import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/web.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_popup.dart';
import 'package:sim_klinik_mobile/services/auth/registration_account_service.dart';

class RegisterAccountController extends GetxController {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final noTelpController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  final Logger log = Logger();
  final GetStorage _box = GetStorage();
  final RegistrationAccountService registrationAccountService =
      RegistrationAccountService();
  final isSnackbarOpen = false.obs;
  final isLoading = false.obs;
  final isPasswordVisible = true.obs;
  final isPasswordConfirmVisible = true.obs;

  void checkVisible() => isPasswordVisible.toggle();
  void checkVisibleConfirm() => isPasswordConfirmVisible.toggle();

  @override
  void onInit() {
    super.onInit();
  }

  void register() async {
    isLoading.value = true;

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirm = passwordConfirmationController.text.trim();
    final noTelp = noTelpController.text.trim();

    if (username.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        passwordConfirm.isEmpty ||
        noTelp.isEmpty) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Error",
        "tidak boleh ada field yang kosong",
        duration: Duration(seconds: 1),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
      isLoading.value = false;
      return;
    }

    final pass = password.length;
    if (pass <= 7) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Gagal",
        "Masukkan lebih dari 7 huruf password",
        duration: Duration(seconds: 1),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
      return;
    }

    if (password != passwordConfirm) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Gagal",
        "Konfirmasi password harus sesuai dengan password",
        duration: Duration(seconds: 1),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
      return;
    }

    showLoading();
    final result = await registrationAccountService.registerAccount(
      username,
      email,
      noTelp,
      password,
    );
    
    if (result.message == "Email telah digunakan dan belum verifikasi") {
      
    }

    if (result.status == "success") {
      Get.back();
      Get.toNamed("/auth/register/verification", arguments: email);
    } else {
      Get.back();
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Gagal",
        result.message ?? "Registrasi Gagal",
        duration: Duration(seconds: 2),
      );
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });
    }

    isLoading.value = false;
  }

  void showLoading() {
    Get.dialog(
      const LoadingPopup(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
