import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/models/medical_history_model.dart';
import 'package:sim_klinik_mobile/services/home/medical_history_service.dart';

class MedicalHistoryController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  final listHistory = <MedicalHistoryModel>[].obs;
  // final dataHistory = <List<MedicalHistoryModel>>[].obs;

  final MedicalHistoryService medicalHistoryService = MedicalHistoryService();

  @override
  void onInit() async {
    super.onInit();
    final pasienId = _box.read('pasien_id').toString();

    if (pasienId.isEmpty) {
      Get.snackbar("Gagal", "Lakukan pembuatan KIB terlebih dahulu");
      Get.toNamed("/base");
    }
    await fetchListHistory(pasienId);
  }

  Future<void> fetchListHistory(String id) async {
    try {
      final result = await medicalHistoryService.fetchMedicalHistory(id);

      if (result.status == 'success' && result.data != null) {
        final historyList = result.data!
            .whereType<MedicalHistoryModel>()
            .toList();

        listHistory.assignAll(historyList);
      } else {}
    } catch (e) {
      log.f("Error: $e");
    }
  }
}
