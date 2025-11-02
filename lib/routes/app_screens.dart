import 'package:get/get.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_change_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_email_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_verification_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/login_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/register-_account_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/register_account_verification_binding.dart';
import 'package:sim_klinik_mobile/screens/auth/register_account_verification_screen.dart';
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
import 'package:sim_klinik_mobile/landing_page_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_change_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_email_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/login_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/register_account_screen.dart';

class AppScreens {
  static final screens = [
    GetPage(name: "/", page: () => LandingPageScreen()),
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
    GetPage(name: "/base", page: () => BaseScreen()),
  ];
}
