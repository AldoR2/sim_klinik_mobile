import 'package:get/get.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_change_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_email_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_verification_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/login_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/register-_account_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/register_account_verification_binding.dart';
import 'package:sim_klinik_mobile/bindings/features/change_password_binding.dart';
import 'package:sim_klinik_mobile/bindings/features/dashboard_binding.dart';
import 'package:sim_klinik_mobile/bindings/features/disease_detection_binding.dart';
import 'package:sim_klinik_mobile/bindings/features/profile_binding.dart';
import 'package:sim_klinik_mobile/screens/auth/register_account_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/Settings/assistance/assistance_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/change_password_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/edit_profile_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/account_settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/email_confirmation_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/fingerprint_settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/account_settings/otp_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/features/account/settings/settings_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/base_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/booking_form_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/chatbot_medigo/chatbot_display_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/disease_detection.dart';
import 'package:sim_klinik_mobile/screens/features/home/image_adjust_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/medical_history/detail_medical_history_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/medical_history/medical_history_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/schedule/detail_poli_schedule.dart';
import 'package:sim_klinik_mobile/screens/features/home/schedule/poli_schedule.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/medical_history/detail_medical_history_model.dart';
import 'package:sim_klinik_mobile/landing_page_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_change_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_email_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/login_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/register_account_screen.dart';

class AppScreens {
  static final screens = [
    // AUTH SECTION
    GetPage(name: "/", page: () => LandingPageScreen()),

    // GetPage(
    //   name: "/",
    //   page: () => DeteksiPenyakitScreen(),
    //   binding: DiseaseDetectionBinding(),
    // ),
    GetPage(
      name: "/auth/login",
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: "/auth/register",
      page: () => RegisterAccount(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: "/auth/register/verification",
      page: () => RegisterAccountVerificationScreen(),
      binding: RegisterAccountVerificationBinding(),
    ),
    GetPage(
      name: "/auth/forgetPassword",
      page: () => ForgetPasswordEmailScreen(),
      binding: ForgetPasswordEmailBinding(),
    ),
    GetPage(
      name: "/auth/forgetPassword/verification",
      page: () => ForgetPasswordVerificationScreen(),
      binding: ForgetPasswordVerificationBinding(),
    ),
    GetPage(
      name: "/auth/forgetPassword/change",
      page: () => ForgetPasswordChangeScreen(),
      binding: ForgetpasswordChangeBinding(),
    ),

    GetPage(
      name: "/base",
      page: () => BaseScreen(),
      bindings: [DashboardBinding(), ProfileBinding()],
    ),
    // HOME SECTION
    GetPage(
      name: "/home/medical_history/detail_medical_history",
      page: () {
        final RiwayatDetailModel data = Get.arguments;
        return DetailRiwayatScreen(data: data);
      },
    ),
    GetPage(name: "/home/medical_history", page: () => RiwayatBerobatScreen()),
    GetPage(
      name: "/home/disease_detection",
      page: () => DeteksiPenyakitScreen(),
      binding: DiseaseDetectionBinding(),
    ),
    GetPage(
      name: "/home/chatbot_medigo/chatbot_display",
      page: () => DisplayChatMedigoScreen(),
    ),
    GetPage(
      name: "/home/schedule/poli_schedule",
      page: () => PilihPoliScreen(),
    ),
    GetPage(
      name: "/home/schedule/detail_poli_schedule",
      page: () => JadwalPoliScreen(),
    ),
    GetPage(name: '/home/image_adjust', page: () => ImageAdjustScreen()),

    // ACCOUNT SECTION
    GetPage(name: "/account/edit_profile", page: () => EditProfileScreen()),
    GetPage(
      name: "/account/change_password",
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(name: "/account/settings", page: () => SettingsScreen()),
    GetPage(
      name: "/account/account_settings",
      page: () => PengaturanAkunScreen(),
    ),
    GetPage(
      name: "/account/account_settings/email_confirmation",
      page: () => EmailConfirmationScreen(),
    ),
    GetPage(
      name: "/account/account_settings/otp_verification",
      page: () => OtpVerificationScreen(),
    ),
    GetPage(
      name: "/account/account_settings/fingerprint_settings",
      page: () => FingerprintSettingsScreen(),
    ),
    GetPage(name: "/account/assistance", page: () => BantuanScreen()),
    GetPage(name: "/booking_form", page: () => BookingFormScreen()),
  ];
}
