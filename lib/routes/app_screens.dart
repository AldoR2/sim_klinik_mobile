import 'package:get/get.dart';
import 'package:sim_klinik_mobile/screens/features/home/base_screen.dart';
import 'package:sim_klinik_mobile/landing_page_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_change_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_email_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/forget_password_verification_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/login_screen.dart';
import 'package:sim_klinik_mobile/screens/auth/register_account_screen.dart';

class AppScreens {
  static final loginScreen = [
    GetPage(name: "/", page: () => LoginScreen()),
    GetPage(name: "/auth/register", page: () => RegisterAccount()),
    GetPage(name: "/auth/forgetPassword", page: () => ForgetPasswordEmailScreen()),
  ];
  static final baseScreen = [GetPage(name: "/", page: () => BaseScreen())];
}
