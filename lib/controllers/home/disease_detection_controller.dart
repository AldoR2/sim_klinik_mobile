import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:sim_klinik_mobile/models/disease_prediction_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';
import 'package:sim_klinik_mobile/services/home/disease_detection_services.dart';

class DiseaseDetectionController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  final DiseaseDetectionServices diseaseDetectionServices =
      DiseaseDetectionServices();
  final foto = Rxn<File>();
  final ImagePicker picker = ImagePicker();
  final selectedImage = Rxn<File>();

  final fotoExtension = ''.obs;

  static const int maxSize = 5 * 1024 * 1024;

  Future<void> pickImageFromCamera() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (image != null) {
      fotoExtension.value = image.path.split('.').last;
      await _goToAdjustScreen(File(image.path));
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null) {
      fotoExtension.value = image.path.split('.').last;
      await _goToAdjustScreen(File(image.path));
    }
  }

  Future<void> _goToAdjustScreen(File imageFile) async {
    final result = await Get.toNamed(
      '/home/image_adjust',
      arguments: imageFile,
    );
    if (result != null && result is File) {
      selectedImage.value = result;
    }
  }

  Future<DiseasePredictionModel> dummyModelPrediction(File image) async {
    await Future.delayed(const Duration(seconds: 2));

    return DiseasePredictionModel(
      classId: 3,
      confidence: 0.92,
      inferenceTimeMs: 100,
      recommendations: [
        "Jaga kebersihan area yang terinfeksi.",
        "Hindari menggaruk agar tidak memperparah luka.",
        "Gunakan salep antijamur OTC bila tersedia.",
      ],
    );
  }

  Future<DiseasePredictionModel> checkDisease() async {
    try {
      log.d("Tes");
      final fotoFinal = selectedImage.value;

      showLoading();

      log.d("Foto: $fotoFinal");

      final result = await diseaseDetectionServices.fetchPrediction(
        fotoFinal,
        fotoExtension.value,
      );

      if (result.status == "success" && result.data != null) {
        Get.back();

        final DiseasePredictionModel model = result.data!;

        return model;
      } else {
        Get.back();
        return DiseasePredictionModel(
          classId: 0,
          confidence: 0,
          inferenceTimeMs: 0,
          recommendations: [],
        );
      }
    } catch (e) {
      Get.back();
      log.f("Error: $e");
      return DiseasePredictionModel(
        classId: 0,
        confidence: 0,
        inferenceTimeMs: 0,
        recommendations: [],
      );
    }
  }

  Future<String> generateDiseaseReportPDF(DiseasePredictionModel result) async {
    final fontRegular = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Poppins-Black.ttf"),
    );

    final fontBold = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Poppins-Bold.ttf"),
    );

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: fontRegular, bold: fontBold),
    );

    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Laporan Analisis Penyakit Kulit",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "Hasil Prediksi:",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text("- Penyakit: ${result.diseaseName}"),
            pw.Text(
              "- Confidence: ${(result.confidence * 100).toStringAsFixed(2)}%",
            ),
            pw.Text("- Waktu inferensi: ${result.inferenceTimeMs} ms"),

            pw.SizedBox(height: 20),

            pw.Text(
              "Rekomendasi:",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),

            ...result.recommendations.asMap().entries.map(
              (e) => pw.Text("${e.key + 1}. ${e.value}"),
            ),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/hasil_analisa.pdf";
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());
    return filePath;
  }

  void showLoading() {
    Get.dialog(
      const LoadingPopup(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
