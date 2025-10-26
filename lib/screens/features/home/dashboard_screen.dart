import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/doctor_schedule_model.dart';
import '../widgets/doctor_schedule_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final now = DateTime.now();
  int currentWeekOffset = 0; // untuk pindah antar minggu

  final doctorSchedules = [
    DoctorScheduleModel(
      poliName: 'Poli Gigi',
      iconPath: 'assets/icons/ic_poli_gigi.png',
      poliColor: Color(0xFF2088FF),
      doctors: [
        DoctorModel(
          name: 'dr. Bima Aditya Pratama',
          time: '09.00 - 11.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
        DoctorModel(
          name: 'dr. Sinta Lestari',
          time: '12.00 - 14.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
      ],
    ),
    DoctorScheduleModel(
      poliName: 'Poli Umum',
      iconPath: 'assets/icons/ic_poli_umum.png',
      poliColor: Color(0xFFFFC720),
      doctors: [
        DoctorModel(
          name: 'dr. Ratna Kusuma',
          time: '13.00 - 15.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
      ],
    ),
    DoctorScheduleModel(
      poliName: 'Poli Ibu dan Anak',
      iconPath: 'assets/icons/ic_poli_ibu_dan_anak.png',
      poliColor: Color(0xFF18B300),
      doctors: [
        DoctorModel(
          name: 'dr. Bima Aditya Pratama',
          time: '09.00 - 11.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
        DoctorModel(
          name: 'dr. Sinta Lestari',
          time: '12.00 - 14.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
      ],
    ),
    DoctorScheduleModel(
      poliName: 'Poli Gizi',
      iconPath: 'assets/icons/ic_poli_gizi.png',
      poliColor: Color(0xFFE27C00),
      doctors: [
        DoctorModel(
          name: 'dr. Bima Aditya Pratama',
          time: '09.00 - 11.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
        DoctorModel(
          name: 'dr. Sinta Lestari',
          time: '12.00 - 14.00',
          imagePath: 'assets/images/foto_dokter.jpg',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F7FB),
      body: Column(
        children: [
          // 🔹 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C8EF9), Color(0xFF7755E1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔸 Logo dan ikon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/medigo_logo_4.png', height: 60),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/ic_notification.png',
                            height: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/ic_settings.png',
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Halo, Izzul!',
                  style: GoogleFonts.rubik(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Semoga harimu menyenangkan!',
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/ic_smile.png', height: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanya MediGo',
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Tanyakan seputar klinik kami',
                              style: GoogleFonts.rubik(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF1C8EF9), Color(0xFF7755E1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                'Chat',
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/icons/ic_chat_2.png',
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 BAGIAN SCROLLABLE
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // 🔸 Fitur-fitur
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 100, // Diperbesar agar tidak overflow
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildFeatureItem(
                              'assets/icons/ic_riwayat.png',
                              'Riwayat\nBerobat',
                              const Color(0xFFB388FF),
                              const Color(0xFF7E57C2),
                            ),
                            _buildFeatureItem(
                              'assets/icons/ic_jadwal.png',
                              'Lihat Jadwal\nPraktek',
                              const Color(0xFFA5D6A7),
                              const Color(0xFF43A047),
                            ),
                            _buildFeatureItem(
                              'assets/icons/ic_deteksi_penyakit.png',
                              'Deteksi\nPenyakit',
                              const Color(0xFFEF9A9A),
                              const Color(0xFFD32F2F),
                            ),
                            _buildFeatureItem(
                              'assets/icons/ic_tanya_medigo.png',
                              'Tanya\nMediGo',
                              const Color(0xFF90CAF9),
                              const Color(0xFF1976D2),
                            ),
                            _buildFeatureItem(
                              'assets/icons/ic_KIB.png',
                              'Kartu Indek\nBerobat',
                              const Color(0xFFFFF59D),
                              const Color(0xFFFBC02D),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 KALENDER (custom)
                    _buildCalendarSection(),

                    const SizedBox(height: 20),

                    // 🔸 Jadwal Praktik Dokter
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Jadwal Praktik ',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Hari Ini',
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Lihat Semua Jadwal',
                            style: GoogleFonts.rubik(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF7134FC),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 🔸 List Jadwal Dokter
                    ...doctorSchedules
                        .map((item) => DoctorScheduleCard(schedule: item))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    String iconPath,
    String label,
    Color bgColor,
    Color borderColor, {
    VoidCallback? onTap,
  }) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🔸 Ripple animation
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              splashColor: borderColor.withOpacity(0.3),
              highlightColor: borderColor.withOpacity(0.1),
              onTap: onTap ?? () {},
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: bgColor.withOpacity(0.15),
                  border: Border.all(color: borderColor, width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.white, blurRadius: 4),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(iconPath, color: borderColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    final DateTime today = DateTime.now();

    final DateTime referenceDay = DateTime.now().add(
      Duration(days: currentWeekOffset * 7),
    );

    final DateTime startOfWeek = referenceDay.subtract(
      Duration(days: referenceDay.weekday - 1),
    );

    final List<DateTime> weekDays = List.generate(
      7,
      (index) => DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day + index,
      ),
    );

    final String monthLabel =
        "${_getMonthName(referenceDay.month)} ${referenceDay.year}";

    // 🔸 Controller agar auto-scroll ke tanggal hari ini
    final ScrollController scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int todayIndex = weekDays.indexWhere(
        (day) => day.day == today.day && day.month == today.month,
      );
      if (todayIndex != -1) {
        scrollController.jumpTo(
          todayIndex * 75.0,
        ); // posisi horizontal ke tanggal hari ini
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header Bulan & Navigasi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentWeekOffset--;
                  });
                },
                icon: const Icon(Icons.chevron_left, color: Color(0xFF7134FC)),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFEEE6FF),
                  padding: const EdgeInsets.all(6),
                ),
              ),
              Text(
                monthLabel,
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentWeekOffset++;
                  });
                },
                icon: const Icon(Icons.chevron_right, color: Color(0xFF7134FC)),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFEEE6FF),
                  padding: const EdgeInsets.all(6),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // 🔹 Deretan tanggal
        SizedBox(
          height: 100,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: weekDays.length,
            itemBuilder: (context, index) {
              final day = weekDays[index];
              final bool isToday =
                  day.day == today.day &&
                  day.month == today.month &&
                  day.year == today.year;

              return Container(
                width: 70,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF7134FC) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    if (isToday)
                      BoxShadow(
                        color: const Color(0xFF7134FC).withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    else
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getDayName(day),
                      style: GoogleFonts.rubik(
                        color: isToday ? Colors.white : Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${day.day}',
                      style: GoogleFonts.rubik(
                        color: isToday ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isToday)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(Icons.circle, size: 6, color: Colors.white),
                      )
                    else
                      const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 🔹 Fungsi nama hari
  String _getDayName(DateTime date) {
    const List<String> dayNames = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    return dayNames[date.weekday - 1];
  }

  // 🔹 Fungsi nama bulan
  String _getMonthName(int month) {
    const List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return monthNames[month - 1];
  }
}
