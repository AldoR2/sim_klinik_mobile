import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderReuse extends StatelessWidget {
  const HeaderReuse({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Container(height: 300, color: const Color(0xff7134FC)),
        ),
        ClipPath(
          clipper: Bottom2CurveClipper(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff2088FF), Color(0xff7134FC)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned(
          top: 45,
          child: SizedBox(
            // height: 0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/logo_medigo.svg",
                  width: 71,
                  height: 73,
                ),
                SizedBox(height: 5),
                Text(
                  "Medigo",
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 80);

    path.quadraticBezierTo(
      size.width / 3.5,
      size.height - 130,
      size.width * 0.5,
      size.height - 60,
    );

    path.quadraticBezierTo(
      size.width * 0.68,
      size.height,
      size.width,
      size.height - 120,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Bottom2CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 80);

    path.quadraticBezierTo(
      size.width / 3,
      size.height - 170,
      size.width * 0.6,
      size.height - 60,
    );

    path.quadraticBezierTo(
      size.width * 0.73,
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
