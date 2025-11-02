import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/auth/register_account_controller.dart';
import 'package:sim_klinik_mobile/screens/reusables/button_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/textfield_reuse.dart';

class RegisterAccount extends StatelessWidget {
  RegisterAccount({super.key});

  final _controller = Get.find<RegisterAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          HeaderReuse(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3,
              bottom: 30,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Registrasi Akun!",
                  style: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Silahkan isi data dibawah ini",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          ReusableTxtFieldStl(
                            hint: "Email",
                            controllerr: _controller.emailController,
                          ),
                          SizedBox(height: 15),
                          ReusableTxtFieldStl(
                            hint: "No.Handphone",
                            controllerr: _controller.noTelpController,
                          ),
                          SizedBox(height: 15),
                          ReusableTxtFieldStl(
                            hint: "Username",
                            controllerr: _controller.usernameController,
                          ),
                          SizedBox(height: 15),
                          Obx(() {
                            return ReusableTxtFieldStl(
                              controllerr: _controller.passwordController,
                              hint: "Password",
                              obscureText:
                                  !(_controller.isPasswordVisible.value),
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
                          SizedBox(height: 15),
                          Obx(() {
                            return ReusableTxtFieldStl(
                              hint: "Konfirmasi Password",
                              obscureText:
                                  !(_controller.isPasswordConfirmVisible.value),
                              controllerr:
                                  _controller.passwordConfirmationController,
                              suffix: IconButton(
                                onPressed: () {
                                  _controller.checkVisibleConfirm();
                                },
                                icon: Icon(
                                  _controller.isPasswordConfirmVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ButtonReuse(
                  function: () {
                    (!_controller.isSnackbarOpen.value)
                        ? _controller.register()
                        : null;
                  },
                  text: "Submit",
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
