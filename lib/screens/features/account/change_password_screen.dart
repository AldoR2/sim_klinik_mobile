import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/account/change_password_controller.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _controller = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(title: 'Ubah Password'),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.06,
                vertical: h * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.02),

                  Center(
                    child: Container(
                      width: w * 0.35,
                      height: w * 0.35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF7134FC).withOpacity(0.25),
                            Color(0xFF3E8DF4).withOpacity(0.25),
                          ],
                        ),
                      ),

                      child: Center(
                        child: Container(
                          width: w * 0.29,
                          height: w * 0.29,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/ic_change_password2.png',
                              width: w * 0.15,
                              height: w * 0.15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  // 🔹 Judul
                  Text(
                    'Perbarui Password',
                    style: GoogleFonts.nunito(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    'Masukkan kata sandi saat ini dan kata sandi baru Anda.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: w * 0.045,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),

                  SizedBox(height: h * 0.02),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black.withOpacity(0.13),
                  ),
                  SizedBox(height: h * 0.02),

                  _buildLabel('Password Saat Ini *', w),
                  SizedBox(height: h * 0.01),
                  _buildPasswordField(_controller.currentPasswordController, w),

                  SizedBox(height: h * 0.02),

                  // 🔹 Field Password Baru
                  _buildLabel('Password Baru *', w),
                  SizedBox(height: h * 0.01),
                  _buildPasswordField(_controller.newPasswordController, w),

                  SizedBox(height: h * 0.02),

                  // 🔹 Field Konfirmasi Password
                  _buildLabel('Konfirmasi Password Baru *', w),
                  SizedBox(height: h * 0.01),
                  _buildPasswordField(_controller.confirmPasswordController, w),

                  SizedBox(height: h * 0.05),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.035),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7755E1), Color(0xFF1C8EF9)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        _controller.validation();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0),
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: w * 0.055,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label, double w) {
    // Pisahkan teks utama dan tanda *
    final parts = label.split('*');
    final mainText = parts[0].trim();
    final hasAsterisk = label.contains('*');

    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.centerLeft, // 🔹 memastikan teks rata kiri
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: w * 0.04,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(text: mainText),
              if (hasAsterisk)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Color(0xFFB30000)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, double w) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        hintText: '********',
        hintStyle: GoogleFonts.poppins(fontSize: w * 0.038),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: w * 0.035,
          horizontal: w * 0.04,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
