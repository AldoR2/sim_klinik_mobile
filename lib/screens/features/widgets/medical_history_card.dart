import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/medical_history/medical_history_model.dart';

class MedicalHistoryCard extends StatelessWidget {
  final MedicalHistoryModel data;
  final VoidCallback onDetailPressed;
  final VoidCallback onDiagnosaPressed;

  const MedicalHistoryCard({
    super.key,
    required this.data,
    required this.onDetailPressed,
    required this.onDiagnosaPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = MediaQuery.of(context).textScaleFactor;

    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: width * 0.02),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.keterangan,
            style: GoogleFonts.inter(
              fontSize: 18 / scale,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7755E1),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.namapoli,
            style: GoogleFonts.inter(
              fontSize: 15 / scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(data.waktu, style: GoogleFonts.inter(fontSize: 14 / scale)),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        data.pemesanan,
                        style: GoogleFonts.rubik(
                          fontSize: 11 / scale,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.phone_android_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey.withOpacity(0.4)),
          const SizedBox(height: 16),

          Center(
            child: Container(
              height: 40,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1C8EF9), Color(0xFF7755E1)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: onDetailPressed,
                child: Text(
                  "Lihat Detail",
                  style: GoogleFonts.rubik(
                    fontSize: 15 / scale,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
