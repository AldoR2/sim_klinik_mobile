import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/disease_detection_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';

class DeteksiPenyakitScreen extends StatefulWidget {
  const DeteksiPenyakitScreen({super.key});

  @override
  State<DeteksiPenyakitScreen> createState() => _DeteksiPenyakitScreenState();
}

class _DeteksiPenyakitScreenState extends State<DeteksiPenyakitScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // === Dummy model prediksi (sementara) ===
  Future<DeteksiResultModel> dummyModelPrediction(File image) async {
    await Future.delayed(const Duration(seconds: 2));

    return DeteksiResultModel(
      diseaseName: "Tinea Versicolor",
      accuracy: 0.92,
      recommendations: [
        "Jaga kebersihan area yang terinfeksi.",
        "Hindari menggaruk agar tidak memperparah luka.",
        "Gunakan salep antijamur OTC bila tersedia.",
      ],
    );
  }

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

  // ============================
  // POPUP ANALISA HASIL
  // ============================
  void _showDetectionResult(DeteksiResultModel result) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Text(
                  "Analisa Hasil",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF7134FC),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),

              const SizedBox(height: 12),
              _buildRow("Nama Penyakit (Prediksi)", result.diseaseName),
              _buildRow(
                "Tingkat Kebenaran",
                "${(result.accuracy * 100).toStringAsFixed(0)}%",
              ),
              const SizedBox(height: 16),

              Text("Rekomendasi Awal", style: _labelStyle),
              const SizedBox(height: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  result.recommendations.length,
                  (i) => Text(
                    "${i + 1}. ${result.recommendations[i]}",
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text("Catatan", style: _labelStyle),
              const SizedBox(height: 4),
              const Text(
                "*Hasil ini bersifat indikatif dan bukan diagnosis final. "
                "Konsultasikan dengan dokter kulit untuk pemeriksaan lebih lanjut.",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF7134FC), // warna ungu
                          width: 1,
                        ),
                        foregroundColor: Color(
                          0xFF7134FC,
                        ), // warna teks dan icon
                      ),
                      child: const Text("Simpan PDF"),
                    ),
                  ),

                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7134FC),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Konsultasi Dokter",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: _labelStyle)),
          Text(":", style: _labelStyle),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF7134FC),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        // Tinggi gambar responsif
        double imageHeight = screenHeight * 0.5;
        if (imageHeight > 420)
          imageHeight = 420; // batas maksimal agar tidak terlalu tinggi

        bool isSmallScreen = screenWidth < 360;

        return Scaffold(
          backgroundColor: const Color(0xFFE7F0FB),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                CustomHeader(title: "Deteksi Penyakit"),
                SizedBox(height: 24),

                // ==============================
                // AREA GAMBAR RESPONSIF
                // ==============================
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
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
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
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

                // ==================================
                // TOMBOL UPLOAD & CAMERA RESPONSIF
                // ==================================
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickImageFromGallery,
                          icon: const Icon(
                            Icons.upload_file,
                            color: Color(0xFF7134FC),
                          ),
                          label: Text(
                            "Upload File",
                            style: GoogleFonts.nunito(
                              color: Color(0xFF7134FC),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFF7134FC)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickImageFromCamera,
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Ambil Gambar",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 64, 29, 145),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                if (_selectedImage != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Get.dialog(LoadingPopup(), barrierDismissible: false);
                          await Future.delayed(const Duration(seconds: 2));

                          DeteksiResultModel result =
                              await dummyModelPrediction(_selectedImage!);

                          Get.back(); // tutup loading

                          _showDetectionResult(result);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7134FC),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Deteksi Sekarang",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
