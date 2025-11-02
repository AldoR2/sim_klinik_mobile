import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/auth/login_controller.dart';
import 'package:sim_klinik_mobile/screens/reusables/button_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/textfield_reuse.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _controller = Get.find<LoginController>();

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
                  ReusableTxtFieldStl(
                    hint: "Username",
                    controllerr: _controller.usernameController,
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return ReusableTxtFieldStl(
                      hint: (!_controller.isPasswordVisible.value)
                          ? "********"
                          : "Password",
                      controllerr: _controller.passwordController,
                      obscureText: !_controller.isPasswordVisible.value,
                      suffix: IconButton(
                        onPressed: () {
                          _controller.checkVisible();
                        },
                        icon: Icon(
                          _controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                  ButtonReuse(
                    function: () {
                      (!_controller.isSnackbarOpen.value)
                          ? _controller.login()
                          : null;
                    },
                    text: "Login",
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
