import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/medical_history/detail_medical_history_model.dart';

class DetailRiwayatScreen extends StatelessWidget {
  final RiwayatDetailModel data;

  const DetailRiwayatScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(width * 0.025),
                      decoration: BoxDecoration(
                        color: Color(0xFF7134FC).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: width * 0.045,
                        color: Color(0xFF7134FC),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.035),
                  Text(
                    "Detail Riwayat",
                    style: GoogleFonts.nunito(
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF7134FC),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.025),

              // Status Pemesanan
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.035,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "PEMESANAN BERHASIL",
                      style: GoogleFonts.nunito(
                        fontSize: width * 0.05,
                        color: Color(0xFF7134FC),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Divider(height: height * 0.012),
                    Text(
                      "PEMESANAN ID : #${data.idPemesanan}",
                      style: GoogleFonts.nunito(
                        fontSize: width * 0.04,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.035),
              Text(
                "KETERANGAN",
                style: GoogleFonts.nunito(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5126B4),
                ),
              ),
              SizedBox(height: height * 0.015),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildRow(context, "Nama Pasien", data.namapasien),
                    _buildRow(context, "Poli", data.namapoli),
                    _buildRow(context, "Dokter", data.namadokter),
                    _buildRow(context, "Tanggal", data.tanggal),
                    _buildRow(context, "Jam", data.jam),

                    // Button Lihat Diagnosa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hasil Diagnosa",
                          style: GoogleFonts.nunito(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF7134FC),
                            minimumSize: Size(width * 0.012, width * 0.08),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Lihat Hasil Diagnosa",
                            style: GoogleFonts.nunito(
                              fontSize: width * 0.035,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.download,
                              size: width * 0.05,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Download PDF",
                              style: GoogleFonts.nunito(
                                fontSize: width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3D4EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.015,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              size: width * 0.05,
                              color: Color(0xFF7134FC),
                            ),
                            label: Text(
                              "Bagikan",
                              style: GoogleFonts.nunito(
                                fontSize: width * 0.045,
                                color: Color(0xFF3D4EFF),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Color(0xFF3D4EFF)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.015,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return Padding(
      padding: EdgeInsets.only(bottom: isTablet ? 16 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: isTablet ? 17 : 14.5,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Value
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontSize: isTablet ? 17 : 15,
                color: const Color(0xFF7134FC),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
