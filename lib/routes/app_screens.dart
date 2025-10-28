import 'package:get/get.dart';
import 'package:sim_klinik_mobile/screens/authentication/login_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/chatbot_medigo/chatbot_display_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/disease_detection.dart';
import 'package:sim_klinik_mobile/screens/features/home/medical_history/detail_medical_history_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/medical_history/medical_history_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/base_screen.dart';
import 'package:sim_klinik_mobile/screens/features/home/schedule/detail_poli_schedule.dart';
import 'package:sim_klinik_mobile/screens/features/home/schedule/poli_schedule.dart';
import 'package:sim_klinik_mobile/screens/features/models/medical_history/detail_medical_history_model.dart';

class AppScreens {
  static const login = '/';
  static const base = '/base';
  static const medical = '/medical-history';
  static const poli_schedule = '/poli-schedule';
  static const detail_history = '/detail-medical-history';
  static const disease_detection = '/disease-detection-history';
  static const display_medigo = '/display-chat-medigo';
  static const detail_poli_schedule = '/detail-poli-schedule';

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
  ];
}
