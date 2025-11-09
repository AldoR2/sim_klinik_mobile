import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/schedule/poli_model.dart';

class PoliCard extends StatelessWidget {
  final PoliModel poli;
  final VoidCallback onTap;
  final Color color;

  final double? width;
  final double? height;

  const PoliCard({
    super.key,
    required this.poli,
    required this.onTap,
    required this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = width ?? screenWidth * 0.9;
    final cardHeight = height ?? screenHeight * 0.12;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Center(
        child: Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          shadowColor: Colors.black.withOpacity(0.08),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            // onTap: () => Get.toNamed(AppScreens.detail_poli_schedule),
            splashColor: color.withOpacity(0.15),
            highlightColor: color.withOpacity(0.08),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.018,
              ),
              child: Row(
                children: [
                  Image.asset(
                    poli.imagePath,
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                    color: color,
                  ),
                  SizedBox(width: screenWidth * 0.035),
                  Expanded(
                    child: Text(
                      poli.namaPoli,
                      style: GoogleFonts.rubik(
                        color: color,
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: color,
                    size: screenWidth * 0.045,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
