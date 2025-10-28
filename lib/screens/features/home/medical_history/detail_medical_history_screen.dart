import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/screens/features/models/medical_history/detail_medical_history_model.dart';

class DetailRiwayatScreen extends StatelessWidget {
  final RiwayatDetailModel data;

  const DetailRiwayatScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF7134FC).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Color(0xFF7134FC),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Detail Riwayat",
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF7134FC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Status Pemesanan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "PEMESANAN BERHASIL",
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        color: Color(0xFF7134FC),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(height: 12),
                    Text(
                      "PEMESANAN ID : #${data.idPemesanan}",
                      style: GoogleFonts.rubik(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Text(
                "KETERANGAN",
                style: GoogleFonts.rubik(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5126B4),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildRow("Nama Pasien", data.namapasien),
                    _buildRow("Poli", data.namapoli),
                    _buildRow("Dokter", data.namadokter),
                    _buildRow("Tanggal", data.tanggal),
                    _buildRow("Jam", data.jam),

                    // Button Lihat Diagnosa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hasil Diagnosa",
                          style: GoogleFonts.rubik(fontSize: 15),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7134FC),
                            minimumSize: const Size(130, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Lihat Hasil Diagnosa",
                            style: GoogleFonts.rubik(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.download,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Download PDF",
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3D4EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share,
                              size: 18,
                              color: Color(0xFF7134FC),
                            ),
                            label: Text(
                              "Bagikan",
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: const Color(0xFF3D4EFF),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF3D4EFF)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
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
          Text(label, style: GoogleFonts.rubik(fontSize: 15)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.rubik(
                fontSize: 15,
                color: const Color(0xFF7134FC),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
