import 'package:get/get.dart';
import 'package:sim_klinik_mobile/bindings/auth/login_binding.dart';
import 'package:sim_klinik_mobile/screens/auth/register_account_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/base_screen.dart';
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
    GetPage(name: "/auth/register", page: () => RegisterAccount()),
    GetPage(
      name: "/auth/register/verification",
      page: () => RegisterAccountVerificationScreen(),
    ),
    GetPage(
      name: "/auth/forgetPassword",
      page: () => ForgetPasswordEmailScreen(),
    ),
    GetPage(
      name: "/auth/forgetPassword/verification",
      page: () => ForgetPasswordVerificationScreen(),
    ),
    GetPage(
      name: "/auth/forgetPassword/change",
      page: () => ForgetPasswordChangeScreen(),
    ),
    GetPage(name: "/base", page: () => BaseScreen()),
  ];
}
