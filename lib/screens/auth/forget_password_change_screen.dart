import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/textfield_reuse.dart';

class ForgetPasswordChangeScreen extends StatelessWidget {
  const ForgetPasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          HeaderReuse(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.only(top: 150),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Perubahan Password",
                  style: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Silahkan masukkan password baru",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),
                SizedBox(height: 30),
                ReusableTxtFieldStl(
                  hint: "New Password",
                  suffix: Icon(Icons.remove_red_eye),
                ),
                SizedBox(height: 15),
                ReusableTxtFieldStl(
                  suffix: Icon(Icons.remove_red_eye),
                  hint: "Confirm Password",
                ),
                SizedBox(height: 30),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff2088FF), Color(0xff7134FC)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xff7134FC),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                        alignment: Alignment.center,
                      ),
                      child: Text(
                        "Submit",
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
                SizedBox(height: 15),
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
                        Get.toNamed("/");
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
