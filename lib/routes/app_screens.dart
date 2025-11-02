import 'package:get/get.dart';
import 'package:sim_klinik_mobile/screens/authentication/login_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/Settings/assistance/assistance_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/change_password_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/edit_profile_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/account_settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/email_confirmation_screen.dart';
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
  static const login = '/';
  static const base = '/base';
  static const medical = '/medical-history';
  static const poli_schedule = '/poli-schedule';
  static const detail_history = '/detail-medical-history';
  static const disease_detection = '/disease-detection-history';
  static const display_medigo = '/display-chat-medigo';
  static const detail_poli_schedule = '/detail-poli-schedule';
  static const edit_profile = '/edit-profile';
  static const change_password = '/change-password';
  static const settings = '/settings';
  static const account_settings = '/account-settings';
  static const assistance = '/assistance';
  static const email_confirmation = '/email-confirmation';
  static const otp_verification = '/otp-verification';

  static final routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: base, page: () => BaseScreen()),
    GetPage(name: poli_schedule, page: () => PilihPoliScreen()),
    GetPage(name: medical, page: () => RiwayatBerobatScreen()),
    GetPage(name: disease_detection, page: () => DeteksiPenyakitScreen()),
    GetPage(
      name: detail_history,
      page: () {
        final RiwayatDetailModel data = Get.arguments;
        return DetailRiwayatScreen(data: data);
      },
    ),
    GetPage(name: display_medigo, page: () => DisplayChatMedigoScreen()),
    GetPage(name: detail_poli_schedule, page: () => JadwalPoliScreen()),
    GetPage(name: edit_profile, page: () => EditProfileScreen()),
    GetPage(name: change_password, page: () => ChangePasswordScreen()),
    GetPage(name: settings, page: () => SettingsScreen()),
    GetPage(name: account_settings, page: () => PengaturanAkunScreen()),
    GetPage(name: assistance, page: () => BantuanScreen()),
    GetPage(name: email_confirmation, page: () => EmailConfirmationScreen()),
    GetPage(name: otp_verification, page: () => OtpVerificationScreen()),
  ];
}
