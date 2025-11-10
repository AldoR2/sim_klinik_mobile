import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';
import 'package:switcher_button/switcher_button.dart';

class FingerprintSettingsScreen extends StatefulWidget {
  const FingerprintSettingsScreen({super.key});

  @override
  State<FingerprintSettingsScreen> createState() =>
      _FingerprintSettingsScreenState();
}

class _FingerprintSettingsScreenState extends State<FingerprintSettingsScreen> {
  bool _notifEnabled = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    final double basePadding = w * 0.045;
    final double iconSize = w * 0.065;
    final double avatarSize = w * 0.115;
    final double fontTitle = 18 * textScale;
    final double fontSubtitle = 15 * textScale;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(title: 'Login dengan Sidik Jari'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.06,
                vertical: h * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.02),
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
                              'assets/icons/ic_fingerprint.png',
                              width: h * 0.07,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),

                  Text(
                    'Login dengan Sidik Jari',
                    style: GoogleFonts.nunito(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    'Akses MediGo dengan cara yang aman dan mudah menggunakan sidik jari.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: w * 0.04,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),

                  SizedBox(height: h * 0.02),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black.withOpacity(0.13),
                  ),
                  SizedBox(height: h * 0.02),

                  _buildSettingItem(
                    context,
                    icon: Icons.fingerprint_rounded,
                    title: "Aktifkan Login dengan Sidik Jari",
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
                ],
              ),
            ),
          ],
        ),
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
  required double fontSubtitle,
  required double basePadding,
  VoidCallback? onTap,
  Widget? trailing,
  String? trailingText,
}) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.rubik(
                fontSize: fontTitle,
                fontWeight: FontWeight.w500,
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
  );
}
