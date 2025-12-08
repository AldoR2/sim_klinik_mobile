import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/models/schedule_doctor_model.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/doctor_schedule_model.dart';
import 'package:sim_klinik_mobile/services/base/dashboard_service.dart';

class DashboardController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();
  var isLoading = true.obs;
  var data = {}.obs;
  final listSchedule = <ScheduleDoctorModel>[].obs;
  final doctorModel = <DoctorModel>[].obs;
  final doctorScheduleModel = <DoctorScheduleModel>[].obs;

  final DashboardService dashboardService = DashboardService();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
    final username = _box.read("username");
    data.addAll({"username": username});
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    try {
      listSchedule.clear();

      final result = await dashboardService.fetchScheduleDoctor();

      if (result.status == "success" && result.data != null) {
        final scheduleList = result.data!
            .whereType<ScheduleDoctorModel>()
            .toList();
        log.d(scheduleList);
        listSchedule.assignAll(scheduleList);
      } else {
        Get.snackbar("Gagal", "Tidak ada jadwal yang tersedia");
      }
    } catch (e) {
      log.e("Error: $e");
    }
  }
}
