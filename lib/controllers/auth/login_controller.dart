import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/web.dart';
import 'package:sim_klinik_mobile/models/pasien_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';
import 'package:sim_klinik_mobile/services/auth/login_service.dart';
import 'package:sim_klinik_mobile/services/token_service.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isSnackbarOpen = false.obs;
  final isLoading = false.obs;

  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  final pasien = Rxn<Pasien>();
  final tokenService = Get.find<TokenService>();
  final LoginService loginService = LoginService();

  void checkVisible() => isPasswordVisible.toggle();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkStatusLogin();
    });
  }

  void checkStatusLogin() {
    // final statusUser = _box.read("logged");

    // if (statusUser == true) {
    //   Get.offAllNamed("/base");
    // }
  }

  void login() async {
    isLoading.value = true;

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Error",
        "Username dan Password tidak boleh kosong",
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

    showLoading();
    final result = await loginService.loginPasien(username, password);

    if (result.status == "success") {
      Get.back();
      pasien.value = result;
      _box.write("logged", true);
      Get.offAllNamed("/base");
    } else {
      Get.back();
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Gagal",
        result.message ?? "Login Gagal",
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
