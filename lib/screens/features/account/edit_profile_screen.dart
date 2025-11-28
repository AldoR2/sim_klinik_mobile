import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/account/edit_profile_controller.dart';
import 'package:sim_klinik_mobile/screens/features/models/account/edit_profile_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileModel user;
  final _controller = Get.find<EditProfileController>();

  @override
  void initState() {
    super.initState();
    user = EditProfileModel(
      nama: "Izzul Islam Ramadhan",
      email: "izzul123@gmail.com",
      fotoProfil: "assets/images/default profile.png",
      isEmailVerified: false, // contoh: email sudah terdaftar
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7755E1), Color(0xFF1C8EF9)],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextButton(
            onPressed: () async {
              Get.dialog(LoadingPopup(), barrierDismissible: false);
              await Future.delayed(const Duration(seconds: 5));
              if (Get.isDialogOpen ?? false) Get.back();
              Get.toNamed("base");
            },
            child: Text(
              "Simpan",
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: w * 0.06,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),

      // ======================
      // 🔺 BODY PAGE
      // ======================
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  height: h * 0.19,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          "Edit Profile",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 35),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 110),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: Get.context!,
                            barrierDismissible: true,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.zero,
                              child: Stack(
                                children: [
                                  // Background blur
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),

                                  // FOTO ZOOM BESAR
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: Center(
                                      child: ClipOval(
                                        child: Obx(() {
                                          final imageUrl =
                                              _controller.storedProfile.value;
                                          return (imageUrl.isNotEmpty)
                                              ? FadeInImage.assetNetwork(
                                                  placeholder:
                                                      "assets/images/foto_user.jpg",
                                                  image: imageUrl,
                                                  height: 300,
                                                  width: 300,
                                                  fit: BoxFit.cover,
                                                  imageErrorBuilder:
                                                      (
                                                        context,
                                                        url,
                                                        error,
                                                      ) => Image.asset(
                                                        "assets/images/foto_user.jpg",
                                                        height: 300,
                                                        width: 300,
                                                        fit: BoxFit.cover,
                                                      ),
                                                )
                                              : Image.asset(
                                                  "assets/images/foto_user.jpg",
                                                  height: 300,
                                                  width: 300,
                                                  fit: BoxFit.cover,
                                                );
                                        }),
                                      ),
                                    ),
                                  ),

                                  // TOMBOL CLOSE
                                  Positioned(
                                    top: 40,
                                    right: 20,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () => Get.back(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },

                        // FOTO PROFIL (KECIL)
                        child: Obx(() {
                          final imageUrl = _controller.storedProfile.value;
                          return (imageUrl.isNotEmpty)
                              ? FadeInImage.assetNetwork(
                                  placeholder: "assets/images/foto_user.jpg",
                                  image: imageUrl,
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (context, url, error) =>
                                      Image.asset(
                                        "assets/images/foto_user.jpg",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.cover,
                                      ),
                                )
                              : Image.asset(
                                  "assets/images/foto_user.jpg",
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                );
                        }),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 80,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _controller.showFileOptions(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7134FC),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.04),

            // ======================
            // FORM FIELD
            // ======================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel("Username"),
                  _buildTextField(user.nama, Icons.edit),

                  _buildFieldLabel("Email"),
                  _buildEmailField(user.email),

                  SizedBox(height: h * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Label teks di atas field
  Widget _buildFieldLabel(String label) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.02, top: w * 0.04),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: w * 0.045,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 🔸 Field teks umum
  Widget _buildTextField(String value, IconData icon) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: value,
          hintStyle: GoogleFonts.nunito(
            color: Colors.black54,
            fontSize: w * 0.045,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: Icon(icon, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: w * 0.04,
          ),
        ),
      ),
    );
  }

  // 🔸 Field Email + Verifikasi
  // 🔸 Field Email + Status di bawah field
  Widget _buildEmailField(String email) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================
        // 🔹 FIELD EMAIL
        // ==========================
        Container(
          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: email,
              hintStyle: GoogleFonts.nunito(
                color: Colors.black54,
                fontSize: w * 0.045,
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none,
            ),
          ),
        ),

        SizedBox(height: w * 0.025),

        // ==========================
        // 🔹 STATUS (di luar field)
        // ==========================
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                if (!user.isEmailVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Silahkan lakukan pembuatan KIB di klinik",
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 16,
                        right: 16,
                      ),
                    ),
                  );
                }
              },

              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.035,
                  vertical: w * 0.02,
                ),
                decoration: BoxDecoration(
                  color: user.isEmailVerified
                      ? Colors.green.withOpacity(0.12)
                      : Colors.red.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),

                // Row berisi ikon + teks
                child: Row(
                  children: [
                    Icon(
                      user.isEmailVerified
                          ? Icons.check_circle
                          : Icons.warning_amber_rounded,
                      color: user.isEmailVerified ? Colors.green : Colors.red,
                      size: w * 0.045,
                    ),
                    SizedBox(width: w * 0.02),
                    Text(
                      user.isEmailVerified
                          ? "Email sudah terdaftar KIB"
                          : "Email belum terdaftar KIB",
                      style: GoogleFonts.nunito(
                        fontSize: w * 0.037,
                        fontWeight: FontWeight.w700,
                        color: user.isEmailVerified ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
