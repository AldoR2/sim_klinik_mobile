import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sim_klinik_mobile/screens/reusables/header_reuse.dart';
import 'package:sim_klinik_mobile/screens/reusables/textfield_reuse.dart';

class RegisterAccount extends StatelessWidget {
  const RegisterAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          HeaderReuse(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3,
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
                  ReusableTxtFieldStl(hint: "Nama"),
                  SizedBox(height: 15),
                  _buildDropdownField(
                    value: "Laki-laki",
                    hint: "Jenis Kelamin",
                    items: ["Laki-laki", "Perempuan"],
                    onChanged: (val) {},
                  ),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "Tempat Lahir"),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "Tanggal Lahir"),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "Email"),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "No.Handphone"),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "Alamat"),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "Username"),
                  SizedBox(height: 15),
                  ReusableTxtFieldStl(hint: "Password"),
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
                          Get.toNamed("/auth/register/verification");
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
                          "Submit",
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
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hint,
    bool? enabledItem,
    required List<String?> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e ?? '',
                  enabled: (enabledItem != null) ? enabledItem : true,
                  child: Text(e ?? ''),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.06),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // tambahkan ini
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 0, 80, 145),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
