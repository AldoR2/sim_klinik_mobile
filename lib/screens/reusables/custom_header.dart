import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomHeader({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    // Ambil ukuran layar
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: height * 0.06, // responsif untuk notch/top bar
        left: width * 0.06,
        right: width * 0.06,
        bottom: height * 0.035,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7755E1), Color(0xFF1C8EF9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onBack ?? () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(width * 0.025),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: width * 0.045,
              ),
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontSize: width * 0.06, // responsif
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: width * 0.08), // agar simetris dengan ikon di kiri
        ],
      ),
    );
  }
}
