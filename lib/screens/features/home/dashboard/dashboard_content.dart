import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/home/doctor_schedule_model.dart';
import '../../widgets/home/doctor_schedule_card.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final now = DateTime.now();
  int currentWeekOffset = 0;

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
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Column(
      children: [
        _buildHeader(w, h),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(bottom: h * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.025),

                  // FITUR
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    child: SizedBox(
                      height: h * 0.13,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildFeatureItem(
                            'assets/icons/ic_riwayat.png',
                            'Riwayat\nBerobat',
                            const Color(0xFFB388FF),
                            const Color(0xFF7E57C2),
                            onTap: () => Get.toNamed("/home/medical_history"),
                          ),
                          _buildFeatureItem(
                            'assets/icons/ic_jadwal.png',
                            'Lihat Jadwal\nPraktek',
                            const Color(0xFFA5D6A7),
                            const Color(0xFF43A047),
                            onTap: () =>
                                Get.toNamed("/home/schedule/poli_schedule"),
                          ),
                          _buildFeatureItem(
                            'assets/icons/ic_deteksi_penyakit.png',
                            'Deteksi\nPenyakit',
                            const Color(0xFFEF9A9A),
                            const Color(0xFFD32F2F),
                            onTap: () => Get.toNamed("/home/disease_detection"),
                          ),
                          _buildFeatureItem(
                            'assets/icons/ic_tanya_medigo.png',
                            'Tanya\nMediGo',
                            const Color(0xFF90CAF9),
                            const Color(0xFF1976D2),
                            onTap: () => Get.toNamed(
                              "/home/chatbot_medigo/chatbot_display",
                            ),
                          ),
                          _buildFeatureItem(
                            'assets/icons/ic_KIB.png',
                            'Kartu Indeks\nBerobat',
                            const Color(0xFFFFF59D),
                            const Color(0xFFFBC02D),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  _buildCalendarSection(),

                  SizedBox(height: h * 0.035),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Jadwal Praktek ',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: w * 0.05,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Hari Ini',
                                  style: GoogleFonts.inter(color: Colors.grey),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Lihat Semua Jadwal',
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF7134FC),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.025),

                  ...doctorSchedules
                      .map((item) => DoctorScheduleCard(schedule: item))
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ========== WIDGET: HEADER ==========
  Widget _buildHeader(double w, double h) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.05, w * 0.05, h * 0.025),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1C8EF9), Color(0xFF7755E1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/medigo_logo_5.png', height: h * 0.05),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: h * 0.035,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed("/account/settings");
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: h * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: h * 0.025),

          Text(
            'Halo, Izzul!',
            style: GoogleFonts.nunito(
              fontSize: w * 0.065,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          SizedBox(height: h * 0.005),

          Text(
            'Semoga harimu menyenangkan!',
            style: GoogleFonts.nunito(
              fontSize: w * 0.045,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),

          SizedBox(height: h * 0.020),

          // Tanya MediGo
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(w * 0.04),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/ic_smile.png', height: h * 0.035),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanya MediGo',
                        style: GoogleFonts.nunito(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Tanyakan seputar klinik kami',
                        style: GoogleFonts.nunito(
                          fontSize: w * 0.037,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.035,
                    vertical: h * 0.010,
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
                          style: GoogleFonts.nunito(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.02),
                      Image.asset(
                        'assets/icons/ic_chat_2.png',
                        height: h * 0.02,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== WIDGET: FEATURE ITEM ==========
  Widget _buildFeatureItem(
    String iconPath,
    String label,
    Color bgColor,
    Color borderColor, {
    VoidCallback? onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final itemWidth = screenWidth * 0.23;
    final iconSize = screenWidth * 0.17;
    final paddingSize = screenWidth * 0.015;
    final textSize = screenWidth * 0.032;
    final spaceBetween = screenHeight * 0.008;

    return SizedBox(
      width: itemWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              splashColor: borderColor.withOpacity(0.15),
              highlightColor: borderColor.withOpacity(0.12),
              child: Padding(
                padding: EdgeInsets.all(paddingSize),
                child: Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70,
                    border: Border.all(color: borderColor, width: 2),
                    boxShadow: [BoxShadow(color: bgColor, blurRadius: 5)],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(iconSize * 0.25),
                    child: Image.asset(iconPath, color: borderColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: spaceBetween),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontSize: textSize,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== WIDGET: KALENDAR ==========
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

    final ScrollController scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int todayIndex = weekDays.indexWhere(
        (day) =>
            day.day == today.day &&
            day.month == today.month &&
            day.year == today.year,
      );
      if (todayIndex != -1) {
        scrollController.jumpTo(todayIndex * 75.0);
      }
    });

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header bulan
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.025),
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
                  padding: EdgeInsets.all(w * 0.015),
                ),
              ),
              Text(
                monthLabel,
                style: GoogleFonts.nunito(
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.w800,
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
                  padding: EdgeInsets.all(w * 0.015),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: h * 0.008),

        // Deretan tanggal
        SizedBox(
          height: h * 0.12,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: w * 0.025),
            itemCount: weekDays.length,
            itemBuilder: (context, index) {
              final day = weekDays[index];
              final bool isToday =
                  day.day == today.day &&
                  day.month == today.month &&
                  day.year == today.year;

              return Container(
                width: w * 0.2,
                margin: EdgeInsets.symmetric(horizontal: w * 0.010),
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF7134FC) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: isToday
                          ? const Color(0xFF7134FC).withOpacity(0.4)
                          : Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getDayName(day),
                      style: GoogleFonts.nunito(
                        color: isToday ? Colors.white : Colors.grey.shade600,
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: h * 0.008),
                    Text(
                      '${day.day}',
                      style: GoogleFonts.nunito(
                        color: isToday ? Colors.white : Colors.black,
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isToday)
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.006),
                        child: const Icon(
                          Icons.circle,
                          size: 6,
                          color: Colors.white,
                        ),
                      )
                    else
                      SizedBox(height: h * 0.012),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

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
