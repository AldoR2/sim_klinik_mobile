import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class BantuanScreen extends StatelessWidget {
  BantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    final double basePadding = width * 0.045;
    final double iconSize = width * 0.065;
    final double avatarSize = width * 0.115;
    final double fontTitle = 18 * textScale;

    return Scaffold(
      backgroundColor: Color(0xFFE7F0FB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(title: "Bantuan"),
          Padding(
            padding: EdgeInsets.only(
              left: basePadding,
              right: basePadding,
              top: height * 0.02,
              bottom: height * 0.01,
            ),
            child: Text(
              "Bantuan Aplikasi",
              style: GoogleFonts.rubik(
                fontSize: 17 * textScale,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),

          // Item email
          _buildSettingItem(
            context,
            icon: Icons.description_rounded,
            title: "Ketentuan Layanan",
            iconSize: iconSize,
            avatarSize: avatarSize,
            fontTitle: fontTitle,
            basePadding: basePadding,
            onTap: () {
              // Get.toNamed(AppScreens.account_settings);
            },
          ),

          _buildSettingItem(
            context,
            icon: Icons.policy,
            title: "Kebijakan Privasi",
            iconSize: iconSize,
            avatarSize: avatarSize,
            fontTitle: fontTitle,
            basePadding: basePadding,
            onTap: () {
              // Get.toNamed(AppScreens.account_settings);
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildSettingItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  required double iconSize,
  required double avatarSize,
  required double fontTitle,
  required double basePadding,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: basePadding, vertical: 6),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: basePadding, vertical: 14),
          child: Row(
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF7134FC),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(icon, color: Colors.white, size: iconSize),
              ),
              SizedBox(width: basePadding * 0.8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.rubik(
                          fontSize: fontTitle,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
