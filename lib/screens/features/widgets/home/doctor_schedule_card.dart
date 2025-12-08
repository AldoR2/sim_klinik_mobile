import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_klinik_mobile/models/schedule_doctor_model.dart';

class DoctorScheduleCard extends StatelessWidget {
  final ScheduleDoctorModel schedule;

  const DoctorScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Baris atas: ikon + nama poli + total dokter
          Row(
            children: [
              Image.asset(
                schedule.iconPath,
                height: 22,
                width: 22,
                color: schedule.poliColor,
              ),
              const SizedBox(width: 6),
              Text(
                schedule.namaPoli!,
                style: TextStyle(
                  color: schedule.poliColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '${schedule.totalDoctor} dokter',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),

          Divider(height: 20, color: Colors.black.withOpacity(0.12)),

          // 🔹 Daftar dokter
          if (schedule.doctors != null && schedule.doctors!.isNotEmpty)
            ...schedule.doctors!.map(
              (doctor) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    // 🔸 Foto dokter dari assets
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        doctor.imagePath ??
                            "assets/images/default profile.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.nama ?? "Dokter",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctor.time ?? "",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
