import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(height: 600, color: const Color(0xff7134FC)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: Top2CurveClipper(),
              child: Container(
                height: 600,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff2088FF), Color(0xff7134FC)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            child: SizedBox(
              // height: 0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/logo_medigo(2).svg",
                    width: 71,
                    height: 73,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Medigo",
                    style: GoogleFonts.rubik(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xff7134FC), Color(0xff2088FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(Rect.fromLTWH(0, 0, 300, 0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            padding: EdgeInsets.only(top: 150),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/auth/register");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(1),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    alignment: Alignment.center,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff2088FF), Color(0xff7134FC)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                        Get.toNamed("/auth/login");
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
                        "Login",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 60);

    // buat lengkungan di bagian atas (arah ke bawah)
    path.quadraticBezierTo(
      size.width * 0.22,
      100, // tinggi lengkungan pertama
      size.width * 0.45,
      20, // titik tengah
    );

    path.quadraticBezierTo(
      size.width * 0.68,
      -40, // tinggi lengkungan kedua
      size.width,
      140, // kanan atas
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Top2CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 54);

    // buat lengkungan di bagian atas (arah ke bawah)
    path.quadraticBezierTo(
      size.width * 0.3,
      140, // tinggi lengkungan pertama
      size.width * 0.565,
      30, // titik tengah
    );

    path.quadraticBezierTo(
      size.width * 0.72,
      -30, // tinggi lengkungan kedua
      size.width,
      50, // kanan atas
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
