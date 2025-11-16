import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sim_klinik_mobile/controllers/auth/register_account_verification_controller.dart';
import 'package:sim_klinik_mobile/screens/reusables/button_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';

class RegisterAccountVerificationScreen extends StatelessWidget {
  RegisterAccountVerificationScreen({super.key});

  final _controller = Get.find<RegisterAccountVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          HeaderReuse(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.only(top: 150),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Aktivasi Akun!",
                  style: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Masukkan 4 digit kode OTP yang dikirimkan ke email  ",
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.4),
                          ),
                        ),
                        TextSpan(
                          text: _controller.storedEmail.value,
                          style: TextStyle(color: Color(0xff0068C9)),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 20),
                PinInputTextField(
                  controller: _controller.otpController,
                  pinLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: BoxLooseDecoration(
                    bgColorBuilder: FixedColorBuilder(
                      Colors.black.withValues(alpha: 0.04),
                    ),
                    strokeColorBuilder: FixedColorBuilder(
                      Colors.black.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum mendapatkan kode? ",
                      style: GoogleFonts.rubik(
                        color: Colors.black.withValues(alpha: 0.4),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          _controller.isButtonEnabled.value
                              ? _controller.send()
                              : null;
                        },
                        child: Text(
                          _controller.textKirim.value,
                          style: GoogleFonts.rubik(
                            color: Color(0xff0068C9),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 40),
                ButtonReuse(
                  function: () {
                    (!_controller.isSnackbarOpen.value)
                        ? _controller.checkOTP()
                        : null;
                  },
                  text: "Selanjutnya",
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/auth/login");
                      },
                      child: Text(
                        "Log In",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff7134FC).withValues(alpha: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
