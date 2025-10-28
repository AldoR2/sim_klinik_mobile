import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/textfield_reuse.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Selamat Datang!",
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Silahkan login terlebih dahulu",
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                  SizedBox(height: 35),
                  ReusableTxtFieldStl(hint: "Username"),
                  SizedBox(height: 20),
                  ReusableTxtFieldStl(
                    hint: "Password",
                    suffix: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    print("Circle clicked!");
                                  },
                                  splashColor: Colors.black.withValues(alpha: 0.2),
                                  customBorder: CircleBorder(),
                                  child: Ink(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: Color(0xff2088FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 17,
                                        width: 17,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // FilledButton(
                              //   style: FilledButton.styleFrom(
                              //     padding: EdgeInsets.zero,
                              //     fixedSize: Size(5, 5),
                              //     backgroundColor: Color(0xff2088FF),
                              //     shape: CircleBorder(),
                              //   ),
                              //   onPressed: () {},
                              //   child: Container(
                              //     height: 5,
                              //     width: 5,
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(width: 3),
                              Text(
                                "Remember Me",
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black.withValues(alpha: 0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/auth/forgetPassword");
                          },
                          child: Text(
                            "Lupa password ?",
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
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
                          Get.toNamed("/base");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xff7134FC),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            foreground: Paint()
                              ..shader =
                                  const LinearGradient(
                                    colors: [
                                      Color(0xff7134FC),
                                      Color(0xff2088FF),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ).createShader(
                                    const Rect.fromLTWH(0, 0, 200, 50),
                                  ),
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
                        "New user?",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/auth/register");
                        },
                        child: Text(
                          "Sign Up",
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
          ),
        ],
      ),
    );
  }
}
