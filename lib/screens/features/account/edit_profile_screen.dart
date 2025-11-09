import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/features/models/account/edit_profile_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileModel user;

  @override
  void initState() {
    super.initState();
    user = EditProfileModel(
      nama: "Izzul Islam Ramadhan",
      email: "izzul123@gmail.com",
      jenisKelamin: "Laki-laki",
      noHandphone: "+62 123 4444 5678",
      fotoProfil: "assets/images/foto_user.jpg",
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Header gradient
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
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 35),
                      ],
                    ),
                  ),
                ),

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
                            backgroundImage: AssetImage(user.fotoProfil),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Edit foto diklik"),
                                ),
                              ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.12),

            /// 🔹 FORM DATA DIRI
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel("Username"),
                  _buildTextField(user.nama, Icons.edit),

                  _buildFieldLabel("Jenis Kelamin"),
                  _buildDropdownField(user.jenisKelamin),

                  _buildFieldLabel("Nomor Handphone"),
                  _buildTextField(user.noHandphone, Icons.edit),

                  _buildFieldLabel("Email"),
                  _buildEmailField(user.email),
                  SizedBox(height: h * 0.05),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7755E1), Color(0xFF1C8EF9)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        Get.dialog(LoadingPopup(), barrierDismissible: false);
                        await Future.delayed(const Duration(seconds: 5));

                        if (Get.isDialogOpen ?? false) Get.back();
                        // Get.toNamed(AppScreens.base);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0),
                        child: Text(
                          "Simpan",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
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
        style: GoogleFonts.rubik(
          fontSize: w * 0.045,
          fontWeight: FontWeight.w600,
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
          hintStyle: GoogleFonts.rubik(
            color: Colors.black54,
            fontSize: w * 0.04,
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

  // 🔸 Dropdown Jenis Kelamin
  Widget _buildDropdownField(String currentValue) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: const InputDecoration(border: InputBorder.none),
        items: ['Laki-laki', 'Perempuan']
            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
            .toList(),
        onChanged: (value) {},
        style: GoogleFonts.rubik(color: Colors.black, fontSize: w * 0.04),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
      ),
    );
  }

  // 🔸 Field Email + Tombol Verifikasi
  Widget _buildEmailField(String email) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return Container(
      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: email,
                hintStyle: GoogleFonts.rubik(
                  color: Colors.black54,
                  fontSize: w * 0.04,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Verifikasi email diklik")),
              );
            },
            child: Text(
              "Verifikasi",
              style: GoogleFonts.rubik(
                color: const Color(0xFF7134FC),
                fontSize: w * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
