import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';
import 'package:sim_klinik_mobile/screens/features/models/account/email_verification_model.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final EmailVerificationModel emailModel = EmailVerificationModel(
    email: "izzul123@gmail.com",
  );

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: 'Verifikasi Email'),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                              child: Image.asset(
                                "assets/icons/ic_email.png",
                                height: h * 0.07,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    // 🔹 Judul
                    Text(
                      'Konfirmasi Kode OTP',
                      style: GoogleFonts.nunito(
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: h * 0.01),

                    // 🔹 Caption email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Masukkan 4 digit kode OTP yang dikirimkan ke email',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.04,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: h * 0.005),
                        Text(
                          emailModel.email,
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.04,
                            color: const Color(0xFF3E8DF4),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.02),
                    Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.13),
                    ),
                    SizedBox(height: h * 0.03),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                            child: SizedBox(
                              width: w * 0.15,
                              height: w * 0.15,
                              child: TextField(
                                controller: otpControllers[index],
                                focusNode: focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.06),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.12),
                                      width: 1.2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7134FC),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.nunito(
                                  fontSize: w * 0.06,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 3) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(focusNodes[index + 1]);
                                  }
                                  if (value.isEmpty && index > 0) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(focusNodes[index - 1]);
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: h * 0.04),

                    // 🔹 Kirim ulang kode
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Kode OTP telah dikirim ulang."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.035,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          children: [
                            TextSpan(text: "Belum menerima kode? "),
                            TextSpan(
                              text: "kirim ulang kode",
                              style: GoogleFonts.nunito(
                                fontSize: w * 0.035,
                                color: const Color(0xFF7134FC),
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Kode OTP telah dikirim ulang.",
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.04),

                    Container(
                      width: double.infinity,
                      height: h * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7134FC), Color(0xFF3E8DF4)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Kode OTP berhasil dikonfirmasi."),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.055,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.025),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ganti Email",
                        style: GoogleFonts.nunito(
                          fontSize: w * 0.04,
                          color: const Color(0xFF7134FC),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
