import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';

class ForgetPasswordVerificationScreen extends StatelessWidget {
  const ForgetPasswordVerificationScreen({super.key});

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
                  "Lupa Password!",
                  style: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "Silahkan isi kode dibawah ini yang kami kirim ke alamat email  ",
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                      ),
                      TextSpan(
                        text: "xxxx@gmail.com",
                        style: TextStyle(color: Color(0xff0068C9)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                PinInputTextField(
                  pinLength: 4,
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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "Belum mendapatkan kode? ",
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                      ),
                      TextSpan(
                        text: "kirim ulang kode",
                        style: TextStyle(color: Color(0xff0068C9)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff2088FF), Color(0xff7134FC)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/auth/forgetPassword/change");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xff7134FC),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                        alignment: Alignment.center,
                      ),
                      child: Text(
                        "Selanjutnya",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [Color(0xff7134FC), Color(0xff2088FF)],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
                        ),
                      ),
                    ),
                  ),
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
