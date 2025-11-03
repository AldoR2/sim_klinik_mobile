import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:http/http.dart' as http;

class TokenService extends GetxService {
  final String global = ApiConstants.globalURL;
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  Future<bool> refreshToken() async {
    final refreshToken = await _box.read("refresh_token");
    log.d("RefreshToken: $refreshToken");

    final url = Uri.parse("${global}auth/refresh");
    log.d("URL Token refresh: $url");

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );

    log.d({"Response status code token: ${response.statusCode}"});

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final newToken = body['token'];
      final newExpires = body['expires_in'];

      await _box.write("auth_token", newToken);
      await _box.write(
        "auth_expires_in",
        (DateTime.now().millisecondsSinceEpoch + (newExpires * 1000))
            .toString(),
      );
      return true;
    } else {
      _box.erase();
      Get.offAllNamed("/login");
      return false;
    }
  }

    Future<void> prepareToken() async {
    final expiresInStr = await _box.read("auth_expires_in");
    final expiresIn = int.tryParse(expiresInStr ?? "0") ?? 0;

    if (DateTime.now().millisecondsSinceEpoch > expiresIn) {
      await refreshToken();
    }
  }
}
