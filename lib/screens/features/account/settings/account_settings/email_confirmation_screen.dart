import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key});

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  final TextEditingController emailController = TextEditingController(
    text: "izzul123@gmail.com",
  );
  bool _isUnderlined = false;

  void _onConfirmTap() {
    setState(() {
      _isUnderlined = true;
    });

    // Navigasi langsung ke halaman OTP
    Get.toNamed(AppScreens.otp_verification);
  }

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
            const CustomHeader(title: 'Verifikasi Email'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.06,
                vertical: h * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.02),
                  // 🔹 Icon amplop
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
                            const Color(0xFF7134FC).withOpacity(0.25),
                            const Color(0xFF3E8DF4).withOpacity(0.25),
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
                            child: Icon(
                              Icons.email_outlined,
                              size: w * 0.18,
                              color: const Color(0xFF7134FC),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),

                  // 🔹 Judul
                  Text(
                    'Konfirmasi Email',
                    style: GoogleFonts.rubik(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    'Email membantu anda untuk mengelola akun, email tidak dapat dilihat oleh pengguna lain.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: w * 0.04,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),

                  SizedBox(height: h * 0.02),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black.withOpacity(0.13),
                  ),
                  SizedBox(height: h * 0.02),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alamat Email",
                      style: GoogleFonts.rubik(
                        fontSize: w * 0.045,
                        color: const Color(0xFF7134FC),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.015),

                  // 🔹 Input Email
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF7134FC).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.grey[600],
                          size: w * 0.06,
                        ),
                        SizedBox(width: w * 0.025),
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            style: GoogleFonts.rubik(
                              fontSize: w * 0.04,
                              color: Colors.grey[700],
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email anda",
                              hintStyle: GoogleFonts.rubik(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  // 🔹 Teks konfirmasi bawah
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: const Color(0xFFFFC107),
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.02),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Apakah ini masih email anda? ",
                            style: GoogleFonts.rubik(
                              fontSize: w * 0.035,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: _onConfirmTap,
                                  child: Text(
                                    "konfirmasi",
                                    style: GoogleFonts.rubik(
                                      fontSize: w * 0.035,
                                      color: const Color(0xFF7134FC),
                                      fontWeight: FontWeight.w500,
                                      decoration: _isUnderlined
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
}
