import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_popup.dart';
import 'package:sim_klinik_mobile/services/auth/forget_password_service.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ForgetpasswordVerificationController extends GetxController {
  final otpController = TextEditingController();

  final Logger log = Logger();
  final GetStorage _box = GetStorage();
  final ForgetPasswordService forgetPasswordService = ForgetPasswordService();

  late StopWatchTimer resendTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(5),
  );

  final isSnackbarOpen = false.obs;
  final isLoading = false.obs;
  final email = ''.obs;
  final delayedSnackbar = 1;
  final isButtonEnabled = true.obs;
  var textKirim = 'Kirim ulang kode'.obs;
  final storedEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments;
    log.d("Email: ${email.value}");
    storedEmail.value = email.value;
  }

  void startTimer() async {
    if (!isButtonEnabled.value) return;
    isButtonEnabled.value = false;

    resendTimer.onResetTimer();
    resendTimer.onStartTimer();

    resendTimer.rawTime.listen((rawTime) {
      final remainingTime = StopWatchTimer.getDisplayTime(
        rawTime,
        milliSecond: false,
        hours: false,
      );
      textKirim.value = remainingTime;
    });

    await Future.delayed(Duration(minutes: 5));
    isButtonEnabled.value = true;
    textKirim.value = "Kirim ulang kode";
  }

  void send() async {
    final emaill = email.value;
    if (isButtonEnabled.value = true) {
      showLoading();
      await resendOTP(emaill);
      startTimer();
    }
  }

  Future<void> resendOTP(String email) async {
    try {
      final result = await forgetPasswordService.sendOTP(email);
      if (result.status == "success") {
        Get.back();
        isSnackbarOpen.value = true;

        Get.snackbar(
          "Berhasil",
          "OTP baru telah dikirim ke $email",
          duration: Duration(seconds: delayedSnackbar),
        );
        Future.delayed(Duration(seconds: 2), () {
          isSnackbarOpen.value = false;
        });
      } else {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar(
          "Gagal",
          result.message,
          duration: Duration(seconds: delayedSnackbar),
        );
        Future.delayed(Duration(seconds: 2), () {
          isSnackbarOpen.value = false;
        });
      }
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

  Future<void> checkOTP() async {
    final emaill = email.value;
    final otp = otpController.text.trim();
    log.d("Kode otp: $otp");

    if (otp.length < 4) {
      isSnackbarOpen.value = true;
      Get.snackbar(
        "Error",
        "OTP harus lengkap",
        duration: Duration(seconds: delayedSnackbar),
      );
      Future.delayed(Duration(seconds: 2), () {
        isSnackbarOpen.value = false;
      });
      return;
    }

    try {
      showLoading();
      final result = await forgetPasswordService.checkOTP(emaill, otp);

      if (result.status == "success") {
        Get.back();
        Get.offNamed("/auth/forgetPassword/change");
      } else {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar("Gagal", result.message);
        Future.delayed(Duration(seconds: 2), () {
          isSnackbarOpen.value = false;
        });
      }
    } catch (e) {
      Get.back();
      log.f("Error: $e");
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
