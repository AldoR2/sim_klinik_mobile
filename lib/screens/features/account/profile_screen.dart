import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/base/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // late UserProfileModel user;
  final _controller = Get.find<ProfileController>();

  // @override
  // void initState() {
  //   super.initState();
  //   user = UserProfileModel(
  //     nama: _controller.data["username"],
  //     email: _controller.data["email"],
  //     fotoProfil: "assets/images/foto_user.jpg",
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Color(0xFFE7F0FB),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: h * 0.19,
                padding: EdgeInsets.only(
                  left: w * 0.05,
                  right: w * 0.05,
                  bottom: h * 0.03,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1C8EF9), Color(0xFF7755E1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: h * 0.035,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: h * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// 🔹 Foto Profil
              Positioned(
                bottom: -h * 0.08,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: w * 0.17,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: w * 0.16,
                          backgroundImage: AssetImage(
                            "assets/images/foto_user.jpg",
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editPhoto,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFF7134FC),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// 🔹 Konten Bawah
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.1),
                child: Column(
                  children: [
                    Obx(() {
                      return Text(
                        _controller.data["username"],
                        style: GoogleFonts.nunito(
                          fontSize: w * 0.07,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      );
                    }),
                    SizedBox(height: h * 0.008),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.03,
                        vertical: h * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Obx(() {
                        return Text(
                          _controller.data["email"],
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.035,
                            color: const Color(0xFF7134FC),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: h * 0.04),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        elevation: 1,
                        shadowColor: Colors.black.withOpacity(0.2),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              icon: 'assets/icons/ic_edit2.png',
                              title: 'Edit Profil',
                              onTap: _editProfile,
                            ),
                            _divider(),
                            _buildMenuItem(
                              icon: 'assets/icons/ic_settings2.png',
                              title: 'Pengaturan',
                              onTap: _openSettings,
                            ),
                            _divider(),
                            _buildMenuItem(
                              icon: 'assets/icons/ic_change_password.png',
                              title: 'Ubah Password',
                              onTap: _changePassword,
                            ),
                            SizedBox(height: h * 0.02),
                            _buildMenuItem2(
                              icon: 'assets/icons/ic_logout.png',
                              title: 'Log Out',
                              onTap: _logout,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.06),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editPhoto() => ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text("Edit foto diklik")));

  void _editProfile() {
    Get.toNamed("/account/edit_profile");
  }

  void _openSettings() {
    Get.toNamed("/account/settings");
  }

  void _changePassword() {
    Get.toNamed("/account/change_password");
  }

  void _logout() => ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text("Logout diklik")));

  Widget _divider() => Divider(height: 1, color: Colors.grey.shade300);

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFF7134FC),
    Color color2 = const Color(0xFFFFFFFF),
    Color color3 = const Color.fromARGB(255, 0, 0, 0),
  }) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: w * 0.04),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(w * 0.025),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Image.asset(
                icon,
                width: w * 0.05,
                height: w * 0.05,
                color: color2,
              ),
            ),
            SizedBox(width: w * 0.05),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: w * 0.05,
                  color: color3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: w * 0.045,
              color: color3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem2({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFFD10000),
  }) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: w * 0.08,
          right: w * 0.06,
          top: w * 0.06,
          bottom: w * 0.06,
        ),
        child: Row(
          children: [
            Image.asset(icon, width: w * 0.06, height: w * 0.06, color: color),
            SizedBox(width: w * 0.06),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: w * 0.05,
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: w * 0.045,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
