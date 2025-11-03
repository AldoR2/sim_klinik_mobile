import 'package:get/get.dart';
import 'package:sim_klinik_mobile/screens/authentication/login_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/Settings/assistance/assistance_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/change_password_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/edit_profile_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/account_settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/email_confirmation_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/fingerprint_settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/otp_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/chatbot_medigo/chatbot_display_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/disease_detection.dart';
import 'package:sim_klinik_mobile/screens/features/home/medical_history/detail_medical_history_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/medical_history/medical_history_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/base_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/schedule/detail_poli_schedule.dart';
import 'package:sim_klinik_mobile/screens/features/home/schedule/poli_schedule.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/medical_history/detail_medical_history_model.dart';

class AppScreens {
  static final routes = [
    GetPage(name: "/base", page: () => BaseScreen()),

    // AUTH SECTION
    GetPage(name: "/auth/login", page: () => LoginScreen()),

    // HOME SECTION
    GetPage(name: "/home/schedule/poli_schedule", page: () => PilihPoliScreen()),
    GetPage(name: "/home/medical_history/medical_history", page: () => RiwayatBerobatScreen()),
    GetPage(name: "/home/schedule/detail_poli_schedule", page: () => JadwalPoliScreen()),
    GetPage(
      name: "/home/medical_history/detail_medical_history",
      page: () {
        final RiwayatDetailModel data = Get.arguments;
        return DetailRiwayatScreen(data: data);
      },
    ),
    GetPage(name: "/home/disease_detection", page: () => DeteksiPenyakitScreen()),
    GetPage(name: "/home/chatbot_medigo/chatbot_display", page: () => DisplayChatMedigoScreen()),

    // ACCOUNT SECTION
    GetPage(name: "/account/edit_profile", page: () => EditProfileScreen()),
    GetPage(name: "/account/change_password", page: () => ChangePasswordScreen()),
    GetPage(name: "/account/settings", page: () => SettingsScreen()),
    GetPage(name: "/account/account_settings", page: () => PengaturanAkunScreen()),
    GetPage(name: "/account/account_settings/email_confirmation", page: () => EmailConfirmationScreen()),
    GetPage(name: "/account/account_settings/otp_verification", page: () => OtpVerificationScreen()),
    GetPage(
      name: "/account/account_settings/fingerprint_settings",
      page: () => FingerprintSettingsScreen(),
    ),
    GetPage(name: "/account/assistance", page: () => BantuanScreen()),
  ];
}
