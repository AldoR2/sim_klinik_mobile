import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
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
                  SizedBox(height: 20),
                  ReusableTxtFieldStl(hint: "Username"),
                  SizedBox(height: 20),
                  ReusableTxtFieldStl(hint: "Password"),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              FilledButton(
                                style: ButtonStyle(
                                  // shape: Out,
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color(0xff2088FF),
                                  ),
                                ),
                                onPressed: () {},
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
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
                        Text(
                          "Lupa password ?",
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(alignment: Alignment.center),
                    child: Text("Login"),
                  ),
                  // textAlign: TextAlign.center,
                  // decoration: InputDecoration(
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   hintText: "Login",
                  //   hintStyle: GoogleFonts.rubik(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
