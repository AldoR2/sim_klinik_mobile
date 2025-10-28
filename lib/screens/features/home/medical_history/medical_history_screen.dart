import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/features/models/medical_history/detail_medical_history_model.dart';
import 'package:sim_klinik_mobile/screens/features/models/medical_history/medical_history_model.dart';
import 'package:sim_klinik_mobile/screens/features/widgets/medical_history_card.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class RiwayatBerobatScreen extends StatelessWidget {
  RiwayatBerobatScreen({super.key});

  final List<MedicalHistoryModel> dataHistory = [
    MedicalHistoryModel(
      keterangan: "Berhasil",
      namapoli: "Poli Umum",
      waktu: "Kamis, 11 September 2025",
      pemesanan: "Pemesanan Via Aplikasi",
    ),
    MedicalHistoryModel(
      keterangan: "Berhasil",
      namapoli: "Poli Gigi",
      waktu: "Kamis, 11 September 2025",
      pemesanan: "Pemesanan Via Klinik",
    ),
    MedicalHistoryModel(
      keterangan: "Berhasil",
      namapoli: "Poli Gizi",
      waktu: "Kamis, 11 September 2025",
      pemesanan: "Pemesanan Via Aplikasi",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Riwayat Berobat"),

          SizedBox(height: screenHeight * 0.015),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              children: [
                /// Search Input
                Expanded(
                  child: Container(
                    height: isTablet ? 60 : 50,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
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
                          width: screenWidth * 0.045,
                          height: screenWidth * 0.045,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.rubik(
                              fontSize: screenWidth * 0.04,
                            ),
                            decoration: InputDecoration(
                              hintText: "Cari Riwayat....",
                              hintStyle: GoogleFonts.rubik(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey.shade600,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.02),

                Container(
                  height: isTablet ? 58 : 46,
                  width: isTablet ? 58 : 46,
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
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Image.asset(
                    "assets/icons/ic_filter.png",
                    width: screenWidth * 0.06,
                    height: screenWidth * 0.06,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
              itemCount: dataHistory.length,
              separatorBuilder: (_, __) =>
                  SizedBox(height: screenHeight * 0.012),
              itemBuilder: (context, index) {
                final item = dataHistory[index];

                return MedicalHistoryCard(
                  data: item,
                  onDiagnosaPressed: () {},
                  onDetailPressed: () {
                    final detailData = RiwayatDetailModel(
                      idPemesanan: "ID${index + 1001}",
                      namapasien: "Izzul Islam Ramadhan",
                      namapoli: item.namapoli,
                      namadokter: "dr. Andi Kusuma",
                      tanggal: item.waktu,
                      jam: "09:00",
                    );

                    Get.toNamed(
                      AppScreens.detail_history,
                      arguments: detailData,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
