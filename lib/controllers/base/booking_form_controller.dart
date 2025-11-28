import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/models/doctor_model.dart';
import 'package:sim_klinik_mobile/models/form_booking_model.dart';
import 'package:sim_klinik_mobile/models/poli_model.dart';
import 'package:sim_klinik_mobile/models/schedule_doctor_model.dart';
import 'package:sim_klinik_mobile/models/sesi_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';
import 'package:sim_klinik_mobile/services/base/booking_form_service.dart';

class BookingFormController extends GetxController {
  final TextEditingController keteranganDokterController =
      TextEditingController(text: "Menunggu pilihan poli & sesi...");
  final TextEditingController keluhanController = TextEditingController();

  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  final selectedPoli = Rxn<PoliModel>(); // nullable Rx<PoliModel>
  final selectedBulan = Rxn<String>();
  final selectedBulanNumber = ''.obs;
  final selectedTanggal = Rxn<String>();
  final selectedSesi = Rxn<SesiModel>();
  final selectedDoctor = Rxn<int>();
  final selectedHari = ''.obs;
  final keluhan = ''.obs;
  final isSnackbarOpen = false.obs;
  final pasienId = ''.obs;

  final listPoli = <PoliModel>[].obs;
  final listDoctor = <DoctorModel>[].obs;
  final listScheduleDoctor = <ScheduleDoctorModel>[].obs;
  final listSesi = <SesiModel>[].obs;

  final BookingFormService bookingFormService = BookingFormService();

  final List<Map<String, String>> jadwalSesi = [
    {"mulai": "07:00", "akhir": "09:00"},
    {"mulai": "09:00", "akhir": "11:00"},
    {"mulai": "13:00", "akhir": "15:00"},
  ];

  int toMinutes(String time) {
    final parts = time.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  Map<String, int> get jumlahHariPerBulan {
    final int year = DateTime.now().year;
    return {
      "Januari": _daysInMonth(year, 1),
      "Februari": _daysInMonth(year, 2),
      "Maret": _daysInMonth(year, 3),
      "April": _daysInMonth(year, 4),
      "Mei": _daysInMonth(year, 5),
      "Juni": _daysInMonth(year, 6),
      "Juli": _daysInMonth(year, 7),
      "Agustus": _daysInMonth(year, 8),
      "September": _daysInMonth(year, 9),
      "Oktober": _daysInMonth(year, 10),
      "November": _daysInMonth(year, 11),
      "Desember": _daysInMonth(year, 12),
    };
  }

  int _daysInMonth(int year, int month) {
    final firstDayNextMonth = (month == 12)
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    final lastDayOfMonth = firstDayNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  String get harii {
    final int year = DateTime.now().year;
    final String? bulan = selectedBulan.value;
    final String? tanggal = selectedTanggal.value;

    if (bulan == null || bulan.isEmpty || tanggal == null || tanggal.isEmpty) {
      return "";
    }

    final Map<String, int> bulanMap = {
      "Januari": 1,
      "Februari": 2,
      "Maret": 3,
      "April": 4,
      "Mei": 5,
      "Juni": 6,
      "Juli": 7,
      "Agustus": 8,
      "September": 9,
      "Oktober": 10,
      "November": 11,
      "Desember": 12,
    };

    int monthNumber = bulanMap[bulan]!;
    selectedBulanNumber.value = monthNumber.toString();
    int day = int.parse(tanggal);

    DateTime date = DateTime(year, monthNumber, day);

    const hariList = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu",
    ];

    return hariList[date.weekday - 1];
  }

  @override
  void onInit() async {
    super.onInit();
    pasienId.value = _box.read("pasien_id").toString();
    log.d("PasienID: ${pasienId.value}");
    await fetchPoli();
    await fetchDokter();
    await fetchJadwal();
  }

  List<String> getTanggalList(String? bulan) {
    if (bulan == null || !jumlahHariPerBulan.containsKey(bulan)) {
      return [];
    }

    int total = jumlahHariPerBulan[bulan]!;
    return List.generate(total, (i) => (i + 1).toString());
  }

  void getHari() {
    selectedHari.value = harii;
    log.d("Hari: ${selectedHari.value}");
  }

  void fetchSesi() {
    final poli = selectedPoli.value;
    final hari = selectedHari.value;

    if (poli == null || hari.isEmpty) {
      listSesi.clear();
      selectedSesi.value = null;
      selectedDoctor.value = null;
      update();
      return;
    }

    final matchingSchedules = listScheduleDoctor
        .where(
          (e) =>
              e.poliId == poli.id &&
              e.hari?.toLowerCase() == hari.toLowerCase(),
        )
        .toList();

    List<SesiModel> availableSesi = [];

    for (var sesi in jadwalSesi) {
      final sesiMulai = toMinutes(sesi["mulai"]!);
      final sesiAkhir = toMinutes(sesi["akhir"]!);

      final overlaps = matchingSchedules.where((schedule) {
        final mulai = toMinutes(schedule.jamMulai!);
        final akhir = toMinutes(schedule.jamAkhir!);
        return !(akhir <= sesiMulai || mulai >= sesiAkhir);
      }).toList();

      if (overlaps.isNotEmpty) {
        overlaps.sort(
          (a, b) => toMinutes(a.jamMulai!).compareTo(toMinutes(b.jamMulai!)),
        );

        final selected = overlaps.first;

        availableSesi.add(
          SesiModel(
            id: availableSesi.length + 1,
            jamMulai: sesi["mulai"]!,
            jamSelesai: sesi["akhir"]!,
            idDokter: selected.dokterId!, // 🔥 simpan Dokter ID!
          ),
        );
      }
    }

    listSesi.assignAll(availableSesi);

    if (!listSesi.contains(selectedSesi.value)) {
      selectedSesi.value = null;
      selectedDoctor.value = null;
    }

    update();
    log.d(
      "Sesi Tersedia: ${listSesi.map((e) => '${e.jamMulai}-${e.jamSelesai}')}",
    );
    log.d("Dokter dipilih: ${selectedDoctor.value}");
  }

  Future<void> fetchPoli() async {
    try {
      listPoli.clear();

      final result = await bookingFormService.fetchListPoli();

      if (result.status == "success" && result.data != null) {
        final poliList = result.data!.whereType<PoliModel>().toList();
        listPoli.assignAll(poliList);
      } else {
        Get.snackbar("Gagal", "Tidak ada poli yang tersedia");
      }
    } catch (e) {
      log.f("Error: $e");
    }
  }

  Future<void> fetchJadwal() async {
    try {
      listScheduleDoctor.clear();

      final result = await bookingFormService.fetchScheduleDoctor();

      if (result.status == "success" && result.data != null) {
        final scheduleList = result.data!
            .whereType<ScheduleDoctorModel>()
            .toList();
        listScheduleDoctor.assignAll(scheduleList);
        log.d(scheduleList);
      } else {
        Get.snackbar("Gagal", "Tidak ada jadwal yang tersedia");
      }
    } catch (e) {
      log.f("Error: $e");
    }
  }

  Future<void> submit() async {
    if (isSnackbarOpen.value == false) {
      final valid = await validation();
      if (valid) {
        fetchForm();
      }
    }
  }

  Future<bool> validation() async {
    keluhan.value = keluhanController.text.trim();

    if (pasienId.value.isEmpty ||
        selectedPoli.value == null ||
        selectedDoctor.value == null ||
        selectedSesi.value == null ||
        selectedBulanNumber.value.isEmpty ||
        selectedTanggal.value == null ||
        keluhan.value.isEmpty) {
      isSnackbarOpen.value = true;
      Get.back();
      Get.snackbar(
        "Gagal",
        "Pastikan seluruh form telah terisi!",
        duration: Duration(seconds: 2),
      );
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });
      return false;
    }
    return true;
  }

  Future<void> fetchForm() async {
    try {
      showLoading();

      final year = DateTime.now().year.toString();
      final month = selectedBulanNumber.value;
      final day = selectedTanggal.value;
      final tglKunjungan = "${year}-${month}-${day}";

      final sesiParts = selectedSesi.value!;
      final jamAwal = sesiParts.jamMulai;
      final jamAkhir = sesiParts.jamSelesai;
      final dokterId = selectedDoctor.value;

      final keluhanAwal = keluhan.value;

      final FormBookingModel formBookingModel = FormBookingModel(
        pasienId: int.parse(pasienId.value),
        poliId: selectedPoli.value!.id,
        dokterId: dokterId,
        jamAwal: jamAwal,
        jamAkhir: jamAkhir,
        tglKunjungan: tglKunjungan,
        keluhanAwal: keluhanAwal,
      );

      final result = await bookingFormService.fetchBooking(formBookingModel);

      if (result.status == "success") {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar(
          "Berhasil",
          "Form antrian berhasil ditambahkan",
          duration: Duration(seconds: 2),
        );
        Future.delayed(Duration(seconds: 3), () {
          isSnackbarOpen.value = false;
        });
        Get.offAllNamed("/base");
      } else {
        Get.back();
        isSnackbarOpen.value = true;
        Get.snackbar("Gagal", result.message, duration: Duration(seconds: 2));
        Future.delayed(Duration(seconds: 3), () {
          isSnackbarOpen.value = false;
        });
      }
    } catch (e) {
      Get.back();
      log.f("Gagal: $e");
      isSnackbarOpen.value = true;
      Get.snackbar("Gagal", "Error: $e", duration: Duration(seconds: 2));
      Future.delayed(Duration(seconds: 3), () {
        isSnackbarOpen.value = false;
      });
    }
  }

  void fetchKeterangan() {
    final idDokter = selectedDoctor.value;
    log.d("ID Dokter: $idDokter");

    if (idDokter == null) {
      keteranganDokterController.text = "Menunggu pilihan poli & sesi...";
      return;
    }

    final dokter = listDoctor.firstWhere(
      (d) => d.id == idDokter,
      orElse: () => DoctorModel(id: 0, nama: "Tidak ditemukan"),
    );

    keteranganDokterController.text = dokter.nama!;
  }

  Future<void> fetchDokter() async {
    try {
      listDoctor.clear();

      final result = await bookingFormService.fetchListDoctor();

      if (result.status == "success" && result.data != null) {
        final dokterList = result.data!.whereType<DoctorModel>().toList();
        listDoctor.assignAll(dokterList);
      } else {
        Get.snackbar("Gagal", "Tidak ada dokter yang tersedia");
      }
    } catch (e) {
      log.f("Error: $e");
    }
  }

  void showLoading() {
    Get.dialog(
      const LoadingPopup(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
