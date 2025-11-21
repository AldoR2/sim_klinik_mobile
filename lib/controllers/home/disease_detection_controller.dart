import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/services/home/disease_detection_services.dart';

class DiseaseDetectionController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  final DiseaseDetectionServices diseaseDetectionServices =
      DiseaseDetectionServices();
  final foto = Rxn<File>();
  final fotoExtension = ''.obs;

  static const int maxSize = 5 * 1024 * 1024;

  Future<void> checkDisease() async {
    try {
      final fotoFinal = foto() == null ? null : foto.value;

      final result = await diseaseDetectionServices.fetchPrediction(
        fotoFinal,
        fotoExtension.value,
      );

      if (result.status == "success") {
        Get.back();
        Get.toNamed("");
      } else {
        Get.back();
      }
    } catch (e) {
      Get.back();
      log.f("Error: $e");
    }
  }
}
