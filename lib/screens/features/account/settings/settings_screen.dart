import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';
import 'package:switcher_button/switcher_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifEnabled = true;

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
    final double fontSubtitle = 15 * textScale;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(title: 'Pengaturan'),

            Padding(
              padding: EdgeInsets.only(
                left: basePadding,
                right: basePadding,
                top: height * 0.02,
                bottom: height * 0.01,
              ),
              child: Text(
                "Pengaturan Aplikasi",
                style: GoogleFonts.rubik(
                  fontSize: 17 * textScale,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),

            // Item pengaturan
            _buildSettingItem(
              context,
              icon: Icons.person,
              title: "Akun",
              subtitle: "Kelola email dan keamanan",
              iconSize: iconSize,
              avatarSize: avatarSize,
              fontTitle: fontTitle,
              fontSubtitle: fontSubtitle,
              basePadding: basePadding,
              onTap: () {
                Get.toNamed("/account/account_settings");
              },
            ),
            _buildSettingItem(
              context,
              icon: Icons.notifications_active,
              title: "Notifikasi",
              subtitle: "Pengingat notifikasi",
              iconSize: iconSize,
              avatarSize: avatarSize,
              fontTitle: fontTitle,
              fontSubtitle: fontSubtitle,
              basePadding: basePadding,
              trailing: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SwitcherButton(
                  value: _notifEnabled,
                  onChange: (value) {
                    setState(() {
                      _notifEnabled = value;
                    });
                  },
                  onColor: Color(0xFF7134FC),
                  offColor: Colors.white,
                ),
              ),
            ),
            _buildSettingItem(
              context,
              icon: Icons.color_lens,
              title: "Personalisasi",
              subtitle: "Atur tema",
              trailingText: "Cerah",
              iconSize: iconSize,
              avatarSize: avatarSize,
              fontTitle: fontTitle,
              fontSubtitle: fontSubtitle,
              basePadding: basePadding,
              onTap: () {},
            ),
            _buildSettingItem(
              context,
              icon: Icons.language,
              title: "Bahasa",
              subtitle: "Atur bahasa",
              trailingText: "Bahasa Indonesia",
              iconSize: iconSize,
              avatarSize: avatarSize,
              fontTitle: fontTitle,
              fontSubtitle: fontSubtitle,
              basePadding: basePadding,
              onTap: () {},
            ),
            _buildSettingItem(
              context,
              icon: Icons.help_outline,
              title: "Bantuan",
              subtitle: "Ketentuan layanan, kebijakan privasi",
              iconSize: iconSize,
              avatarSize: avatarSize,
              fontTitle: fontTitle,
              fontSubtitle: fontSubtitle,
              basePadding: basePadding,
              onTap: () {
                Get.toNamed("/account/assistance");
              },
            ),

            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required double iconSize,
    required double avatarSize,
    required double fontTitle,
    required double fontSubtitle,
    required double basePadding,
    VoidCallback? onTap,
    Widget? trailing,
    String? trailingText,
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
            padding: EdgeInsets.symmetric(
              horizontal: basePadding,
              vertical: 14,
            ),
            child: Row(
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: Color(0xFF7134FC),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(icon, color: Colors.white, size: iconSize),
                ),
                SizedBox(width: basePadding * 0.8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.rubik(
                          fontSize: fontTitle,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.rubik(
                          fontSize: fontSubtitle,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) trailing,
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: GoogleFonts.rubik(
                      fontSize: fontSubtitle,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (trailing == null && trailingText == null)
                  const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
