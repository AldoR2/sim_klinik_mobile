import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/screens/features/account/profile_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/dashboard/dashboard_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/booking_form_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final RxInt _selectedIndex = 0.obs;

  // hanya Dashboard & Profile sekarang (Booking dibuka terpisah)
  final List<Widget> _pages = [const DashboardScreen(), const ProfileScreen()];

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Obx(() => _pages[_selectedIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // PENTING: Pastikan route name sama persis dengan yang didaftarkan di getPages
          Get.toNamed('/booking_form');
        },
        backgroundColor: const Color(0xFF7134FC),
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/icons/ic_booking.png',
          width: screenWidth * 0.065,
          height: screenWidth * 0.065,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: screenHeight * 0.08,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Obx(() {
            final currentIndex = _selectedIndex.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomItem(
                  iconPath: 'assets/icons/ic_home.png',
                  iconPathClicked: 'assets/icons/ic_home_clicked.png',
                  label: 'Beranda',
                  index: 0,
                  currentIndex: currentIndex,
                  screenWidth: screenWidth,
                ),
                _buildBottomItem(
                  iconPath: 'assets/icons/ic_account.png',
                  iconPathClicked: 'assets/icons/ic_account_clicked.png',
                  label: 'Akun',
                  index: 1, // sekarang index 1 (Profile)
                  currentIndex: currentIndex,
                  screenWidth: screenWidth,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBottomItem({
    required String iconPath,
    required String iconPathClicked,
    required String label,
    required int index,
    required int currentIndex,
    required double screenWidth,
  }) {
    final isActive = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: screenWidth * 0.22,
        height: 45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isActive ? iconPathClicked : iconPath,
              width: screenWidth * 0.06,
              height: screenWidth * 0.06,
            ),
            SizedBox(height: screenWidth * 0.008),
            Text(
              label,
              style: GoogleFonts.rubik(
                color: isActive ? const Color(0xFF7134FC) : Colors.grey,
                fontSize: screenWidth * 0.03,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
