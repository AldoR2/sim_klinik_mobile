import 'package:get/get.dart';
import 'package:sim_klinik_mobile/screens/authentication/login_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/base_screen.dart';

class AppScreens {
  static final loginScreen = [GetPage(name: "/", page: () => LoginScreen())];
  static final baseScreen = [GetPage(name: "/", page: () => BaseScreen())];
}
