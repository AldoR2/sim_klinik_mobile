import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class DeteksiPenyakitScreen extends StatefulWidget {
  const DeteksiPenyakitScreen({super.key});

  @override
  State<DeteksiPenyakitScreen> createState() => _DeteksiPenyakitScreenState();
}

class _DeteksiPenyakitScreenState extends State<DeteksiPenyakitScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (image != null) {
      await _goToAdjustScreen(File(image.path));
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null) {
      await _goToAdjustScreen(File(image.path));
    }
  }

  Future<void> _goToAdjustScreen(File imageFile) async {
    final result = await Get.toNamed(
      '/home/image_adjust',
      arguments: imageFile,
    );
    if (result != null && result is File) {
      setState(() {
        _selectedImage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.6;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(title: "Deteksi Penyakit"),
            const SizedBox(height: 16),

            // === Area Gambar ===
            Center(
              child: Container(
                width: size.width * 0.9,
                height: imageHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _selectedImage == null
                      ? const Center(
                          child: Text(
                            "Belum ada gambar",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : Image.file(
                          _selectedImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // === Tombol aksi ===
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.upload_file, color: Color(0xFF7134FC)),
                  label: const Text(
                    "Upload File",
                    style: TextStyle(color: Color(0xFF7134FC)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF7134FC)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.08),
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text(
                    "Ambil Gambar",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7134FC),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // === Tombol Deteksi (muncul jika ada gambar) ===
            if (_selectedImage != null)
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7134FC),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Deteksi Sekarang",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
