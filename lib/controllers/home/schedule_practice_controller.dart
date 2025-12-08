import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/models/doctor_schedule_model.dart';
import 'package:sim_klinik_mobile/models/poli_model.dart';
import 'package:sim_klinik_mobile/services/home/practice_schedule_service.dart';

class SchedulePracticeController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  final listPoli = <PoliModel>[].obs;
  final listSchedule = <DoctorScheduleModel>[].obs;
  final doctorScheduleByDay = <String, List<DoctorScheduleModel>>{}.obs;

  final PracticeScheduleService practiceScheduleService =
      PracticeScheduleService();

  @override
  void onInit() async {
    super.onInit();
    await fetchListPoli();
  }

  Future<void> fetchListPoli() async {
    try {
      listPoli.clear();

      final result = await practiceScheduleService.fetchListPoli();

      if (result.status == "success" && result.data != null) {
        final poliList = result.data!.whereType<PoliModel>().toList();

        for (var poli in poliList) {
          if (poli.nama!.contains("umum")) {
            poli.imagePath = "assets/icons/ic_poli_umum.png";
            poli.color = const Color(0xFFFFC720);
          } else {
            poli.imagePath = "assets/icons/ic_poli_gizi.png";
            poli.color = const Color(0xFFE27C00);
          }
        }
        listPoli.assignAll(poliList);
      } else {}
    } catch (e) {
      log.f("Error: $e");
    }
  }

  void toDetailPoli(int id) async {
    Get.toNamed("/home/schedule/detail_poli_schedule", arguments: id);

    await fetchDetailPoli(id);
  }

  Future<void> fetchDetailPoli(int id) async {
    final idd = id.toString();

    try {
      final result = await practiceScheduleService.fetchSchedulePoli(idd);

      if (result.status == "success" && result.data != null) {
        final scheduleList = result.data!
            .whereType<DoctorScheduleModel>()
            .toList();

        listSchedule.assignAll(scheduleList);

        final Map<String, Set<String>> doctorDays = {};

        for (var item in scheduleList) {
          final doctorId = item.idDokter;
          final day = item.practiceDays.first;

          doctorDays.putIfAbsent(doctorId, () => <String>{});
          doctorDays[doctorId]!.add(day);
        }

        final Map<String, List<DoctorScheduleModel>> grouped = {};

        for (var item in scheduleList) {
          final doctorId = item.idDokter;
          final day = item.practiceDays.first;

          grouped.putIfAbsent(day, () => []);

          final allDays = doctorDays[doctorId]?.toList() ?? [day];

          grouped[day]!.add(
            DoctorScheduleModel(
              idDokter: item.idDokter,
              doctorName: item.doctorName,
              doctorImage: item.doctorImage,
              time: item.time,
              practiceDays: allDays,
              spesialisasi: item.spesialisasi,
            ),
          );
        }

        doctorScheduleByDay.assignAll(grouped);
        doctorScheduleByDay.refresh();
      } else {}
    } catch (e) {
      log.f("Error: $e");
    }
  }
}
