import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/medical_history/detail_medical_history_model.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/medical_history/medical_history_model.dart';
import 'package:sim_klinik_mobile/screens/features/widgets/home/medical_history_card.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class RiwayatBerobatScreen extends StatefulWidget {
  const RiwayatBerobatScreen({super.key});

  @override
  State<RiwayatBerobatScreen> createState() => _RiwayatBerobatScreenState();
}

class _RiwayatBerobatScreenState extends State<RiwayatBerobatScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<MedicalHistoryModel> _dataHistory = [
    MedicalHistoryModel(
      keterangan: "Berhasil",
      namapoli: "Poli Umum",
      waktu: "Kamis, 11 September 2025",
      pemesanan: "Pemesanan Via Aplikasi",
    ),
    MedicalHistoryModel(
      keterangan: "Berhasil",
      namapoli: "Poli Gigi",
      waktu: "Rabu, 10 September 2025",
      pemesanan: "Pemesanan Via Klinik",
    ),
    MedicalHistoryModel(
      keterangan: "Berhasil",
      namapoli: "Poli Gizi",
      waktu: "Senin, 8 September 2025",
      pemesanan: "Pemesanan Via Aplikasi",
    ),
  ];

  List<MedicalHistoryModel> _filteredHistory = [];

  @override
  void initState() {
    super.initState();
    _filteredHistory = _dataHistory; // awalnya tampil semua
  }

  void _filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredHistory = _dataHistory;
      } else {
        _filteredHistory = _dataHistory.where((item) {
          final name = item.namapoli.toLowerCase();
          final day = item.waktu.toLowerCase();
          final search = query.toLowerCase();

          return name.contains(search) || day.contains(search);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Riwayat Berobat"),

          SizedBox(height: height * 0.015),

          /// 🔍 Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Container(
              height: isTablet ? 55 : 45,
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
                      onChanged: _filterSearch,
                      style: GoogleFonts.rubik(fontSize: width * 0.04),
                      decoration: InputDecoration(
                        hintText: "Cari berdasarkan nama poli atau hari...",
                        hintStyle: GoogleFonts.rubik(
                          fontSize: width * 0.04,
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

          SizedBox(height: height * 0.015),

          /// 📋 Daftar Riwayat
          Expanded(
            child: _filteredHistory.isEmpty
                ? Center(
                    child: Text(
                      "Tidak ada hasil ditemukan",
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                        fontSize: width * 0.04,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    itemCount: _filteredHistory.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: height * 0.012),
                    itemBuilder: (context, index) {
                      final item = _filteredHistory[index];

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
