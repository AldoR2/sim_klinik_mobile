import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/models/doctor_schedule_model.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/schedule/detail_schedule_model.dart';

class DetailScheduleCard extends StatelessWidget {
  final DoctorScheduleModel doctor;

  const DetailScheduleCard({
    super.key,
    required this.doctor,
    required Null Function() onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: height * 0.016),
      padding: EdgeInsets.all(width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Foto Dokter
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              doctor.doctorImage!,
              width: width * 0.15,
              height: width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: width * 0.025),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.doctorName,
                  style: GoogleFonts.rubik(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: width * 0.04,
                    ),
                    SizedBox(width: width * 0.01),
                    Text(
                      doctor.time,
                      style: GoogleFonts.rubik(
                        color: Colors.grey[700],
                        fontSize: width * 0.04,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Tombol Lihat Jadwal
          ElevatedButton(
            onPressed: () {
              _showSchedulePopup(context, doctor);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7134FC),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.025,
                vertical: height * 0.01,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Lihat Jadwal',
              style: GoogleFonts.rubik(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSchedulePopup(BuildContext context, DoctorScheduleModel doctor) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Padding(
          padding: EdgeInsets.all(width * 0.035),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Judul
              Text(
                "Jadwal Praktek",
                style: GoogleFonts.rubik(
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7134FC),
                ),
              ),
              SizedBox(height: height * 0.004),
              Container(
                height: height * 0.002,
                width: width * 0.6,
                color: Color(0xFF7134FC).withOpacity(0.5),
              ),
              SizedBox(height: height * 0.025),

              // Foto dokter
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  doctor.doctorImage!,
                  width: width * 0.3,
                  height: width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: height * 0.012),

              // Nama dokter
              Text(
                doctor.doctorName,
                style: GoogleFonts.rubik(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              // Spesialisasi
              Text(
                doctor.spesialisasi,
                style: GoogleFonts.rubik(
                  fontSize: width * 0.038,
                  color: Colors.black54,
                ),
              ),

              SizedBox(height: height * 0.016),
              Divider(color: Colors.grey.shade400, height: height * 0.002),
              SizedBox(height: height * 0.008),

              Column(
                children: doctor.practiceDays.map((day) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          day,
                          style: GoogleFonts.rubik(
                            fontSize: width * 0.04,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: width * 0.045,
                              color: Colors.black45,
                            ),
                            SizedBox(width: width * 0.012),
                            Text(
                              doctor.time,
                              style: GoogleFonts.rubik(
                                fontSize: width * 0.04,
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
              SizedBox(height: height * 0.01),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7134FC),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.024,
                      vertical: height * 0.012,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Tutup',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
