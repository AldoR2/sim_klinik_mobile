import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sim_klinik_mobile/controllers/home/disease_detection_controller.dart';
import 'package:sim_klinik_mobile/models/disease_prediction_model.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/disease_detection_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';

class DeteksiPenyakitScreen extends StatefulWidget {
  DeteksiPenyakitScreen({super.key});

  @override
  State<DeteksiPenyakitScreen> createState() => _DeteksiPenyakitScreenState();
}

class _DeteksiPenyakitScreenState extends State<DeteksiPenyakitScreen> {
  final _controller = Get.find<DiseaseDetectionController>();
  // === Dummy model prediksi (sementara) ===

  // ============================
  // POPUP ANALISA HASIL
  // ============================
  void showDetectionResult(DiseasePredictionModel result) {
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
                "${(result.confidence * 100).toStringAsFixed(0)}%",
              ),
              const SizedBox(height: 16),

              Text("Rekomendasi Awal", style: _labelStyle),
              const SizedBox(height: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (result.recommendations != 1)
                    ? List.generate(
                        result.recommendations.length,
                        (i) => Text(
                          "${i + 1}. ${result.recommendations[i]}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    : [],
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
                      onPressed: () async {
                        print("Press");
                        final path = await _controller.generateDiseaseReportPDF(
                          result,
                        );
                        print("Saved path: $path");
                        OpenFilex.open(path);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF7134FC),
                          width: 1,
                        ),
                        foregroundColor: Color(0xFF7134FC),
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
                      onPressed: () {
                        Get.toNamed("/booking_form");
                      },
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

  // ============================
  // GETTER BOTTOM NAVIGATION BAR
  // ============================
  Widget get _buildBottomNavBar {
    if (_controller.selectedImage.value == null) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 36),
      height: 90,
      child: ElevatedButton(
        onPressed: () async {
          final result = await _controller.checkDisease();
          showDetectionResult(result);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7134FC),
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
    final _controller = Get.find<DiseaseDetectionController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        double imageHeight = screenHeight * 0.5;
        if (imageHeight > 420) imageHeight = 420;

        bool isSmallScreen = screenWidth < 360;

        return Scaffold(
          backgroundColor: const Color(0xFFE7F0FB),
          bottomNavigationBar: Obx(() {
            return _buildBottomNavBar; // ⬅️ PENTING!
          }),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                CustomHeader(title: "Deteksi Penyakit"),
                SizedBox(height: 24),

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
                    child: Obx(() {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _controller.selectedImage.value == null
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
                                _controller.selectedImage.value!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 32),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _controller.pickImageFromGallery,
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
                          onPressed: _controller.pickImageFromCamera,
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
                SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
