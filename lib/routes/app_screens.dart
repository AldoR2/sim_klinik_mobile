import 'package:get/get.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_change_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_email_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/forget_password_verification_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/login_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/register-_account_binding.dart';
import 'package:sim_klinik_mobile/bindings/auth/register_account_verification_binding.dart';
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
