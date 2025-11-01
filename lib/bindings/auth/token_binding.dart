import 'package:get/get.dart';
import 'package:sim_klinik_mobile/services/token_service.dart';

class TokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TokenService>(TokenService(), permanent: true);
  }
}
