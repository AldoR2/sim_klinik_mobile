import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/home/schedule_practice_controller.dart';
import 'package:sim_klinik_mobile/models/doctor_schedule_model.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/schedule/detail_schedule_model.dart';
import 'package:sim_klinik_mobile/screens/features/widgets/home/detail_schedule_card.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class JadwalPoliScreen extends StatefulWidget {
  const JadwalPoliScreen({super.key});

  @override
  State<JadwalPoliScreen> createState() => _JadwalPoliScreenState();
}

class _JadwalPoliScreenState extends State<JadwalPoliScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _controller = Get.find<SchedulePracticeController>();

  // Data dummy asli
  // final Map<String, List<DetailScheduleModel>> doctorScheduleByDay = {
  //   'Senin': [
  //     DetailScheduleModel(
  //       doctorName: 'dr. Bima Achmad Fiil A.',
  //       doctorImage: 'assets/images/foto_dokter.jpg',
  //       time: '09.00 - 11.00',
  //       practiceDays: ['Senin', 'Selasa'],
  //       spesialisasi: 'Dokter Gizi',
  //     ),
  //     DetailScheduleModel(
  //       doctorName: 'dr. Izzul Islam R.',
  //       doctorImage: 'assets/images/foto_dokter2.jpg',
  //       time: '13.00 - 15.00',
  //       practiceDays: ['Senin', 'Rabu'],
  //       spesialisasi: 'Dokter Umum',
  //     ),
  //   ],
  //   'Selasa': [
  //     DetailScheduleModel(
  //       doctorName: 'dr. Bima Aditya Pratama',
  //       doctorImage: 'assets/images/foto_dokter.jpg',
  //       time: '09.00 - 11.00',
  //       practiceDays: ['Selasa'],
  //       spesialisasi: 'Dokter Gadungan',
  //     ),
  //   ],
  //   'Rabu': [
  //     DetailScheduleModel(
  //       doctorName: 'dr. Izzul Islam R.',
  //       doctorImage: 'assets/images/foto_dokter2.jpg',
  //       time: '13.00 - 15.00',
  //       practiceDays: ['Rabu'],
  //       spesialisasi: 'Dokter Gigi',
  //     ),
  //   ],
  //   'Kamis': [
  //     DetailScheduleModel(
  //       doctorName: 'dr. Salsabila Rahman',
  //       doctorImage: 'assets/images/foto_dokter.jpg',
  //       time: '13.00 - 15.00',
  //       practiceDays: ['Kamis', 'Jumat'],
  //       spesialisasi: 'Dokter Spesialis Gigi',
  //     ),
  //     DetailScheduleModel(
  //       doctorName: 'dr. Salsabila Rahman',
  //       doctorImage: 'assets/images/foto_dokter.jpg',
  //       time: '13.00 - 15.00',
  //       practiceDays: ['Kamis'],
  //       spesialisasi: 'Dokter Umum',
  //     ),
  //   ],
  // };

  // Data hasil pencarian
  final filteredDoctorScheduleByDay = <String, List<DoctorScheduleModel>>{}.obs;

  @override
  void initState() {
    super.initState();
    filteredDoctorScheduleByDay.value = Map.from(
      _controller.doctorScheduleByDay,
    );
  }

  // Fungsi pencarian
  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDoctorScheduleByDay.value = Map.from(
          _controller.doctorScheduleByDay,
        );
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    final Map<String, List<DoctorScheduleModel>> filtered = {};

    _controller.doctorScheduleByDay.forEach((day, doctors) {
      final filteredDoctors = doctors.where((doctor) {
        final nameMatch = doctor.doctorName.toLowerCase().contains(lowerQuery);
        return nameMatch;
      }).toList();

      if (filteredDoctors.isNotEmpty) {
        filtered[day] = filteredDoctors;
      }
    });

    setState(() {
      filteredDoctorScheduleByDay.value = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Jadwal Praktek"),
          SizedBox(height: height * 0.015),

          // 🔍 Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Container(
              height: isTablet ? 60 : 50,
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/ic_search2.png",
                    width: width * 0.045,
                    height: width * 0.045,
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: filterSearch,
                      style: GoogleFonts.rubik(fontSize: width * 0.04),
                      decoration: InputDecoration(
                        hintText: "Cari berdasarkan nama dokter...",
                        hintStyle: GoogleFonts.rubik(
                          fontSize: width * 0.04,
                          color: Colors.grey.shade600,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: height * 0.02),

          // 📋 List hasil filter
          Expanded(
            child: Obx(() {
              final data = _controller.doctorScheduleByDay;
              if (_searchController.text.isEmpty) {
                filteredDoctorScheduleByDay.value = Map.from(data);
              }
              return filteredDoctorScheduleByDay.isEmpty
                  ? Center(
                      child: Text(
                        "Tidak ada hasil ditemukan",
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.only(
                        left: width * 0.035,
                        right: width * 0.035,
                        bottom: height * 0.02,
                      ),
                      children: filteredDoctorScheduleByDay.entries.map((
                        entry,
                      ) {
                        final day = entry.key;
                        final doctors = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.015,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    day,
                                    style: GoogleFonts.rubik(
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${doctors.length} dokter',
                                    style: GoogleFonts.rubik(
                                      fontSize: width * 0.035,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...doctors.map(
                              (doctor) => DetailScheduleCard(
                                doctor: doctor,
                                onViewDetail: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (_) =>
                                        _buildDoctorDetailSheet(doctor),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorDetailSheet(DoctorScheduleModel doctor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Jadwal Praktek",
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7755E1),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                width: 60,
                color: const Color(0xFF7755E1).withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  doctor.doctorImage!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                doctor.doctorName,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                doctor.spesialisasi,
                style: GoogleFonts.rubik(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
              Column(
                children: doctor.practiceDays.map((day) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(day, style: GoogleFonts.rubik(fontSize: 14)),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 18,
                              color: Colors.black45,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              doctor.time,
                              style: GoogleFonts.rubik(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
