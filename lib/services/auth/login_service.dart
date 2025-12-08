import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/web.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/pasien_model.dart';
import 'package:sim_klinik_mobile/services/token_service.dart';
import 'package:http/http.dart' as http;

class LoginService extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}auth/login";
  final String global = ApiConstants.globalURL;
  final GetStorage _box = GetStorage();
  final tokenService = Get.find<TokenService>();
  final Logger log = Logger();

  Future<Pasien> loginPasien(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseURL),
        body: {'username': username, 'password': password, 'role': "pasien"},
      );
      log.d("URL: $_baseURL");

      log.d("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        log.d(body);
        log.d(body['data']);

        if (body['status'] == 'success') {
          final token = body['token'];
          final tokenType = body['token_type'];
          final expiresIn = body['expired_at'];
          // final refreshToken = body['refresh_token'];

          await _box.write("auth_token", token);
          await _box.write("auth_token_type", tokenType);
          // await _box.write("refresh_token", refreshToken);

          log.d("Token: $token");
          // log.d("Refresh Token: $refreshToken");
          log.d("Token Type: $tokenType");
          log.d("Expires In: $expiresIn");

          final data = body['data'];
          log.d(data);

          _box.write("user_id", data['user_id']);
          _box.write("email", data['email']);
          _box.write("username", data['username']);
          // _box.write("nama", data['nama']);
          if (data['pasien_id'] != null) {
            _box.write("pasien_id", data['pasien_id']);
            _box.write("status_pasien", 'valid');
          } else {
            _box.write("status_pasien", 'tidakValid');

          }

          return Pasien.fromJson({
            ...data,
            'status': body['status'],
            'message': body['message'],
          });
        } else {
          return Pasien(
            userId: 0,
            email: '',
            username: '',
            pasienId: 0,
            nama: '',
            message: body['message'],
          );
        }
      } else {
        final body = jsonDecode(response.body);

        return Pasien(
          userId: 0,
          email: '',
          username: '',
          pasienId: 0,
          nama: '',
          message: body['message'],
        );
      }
    } catch (e) {
      log.e("Error during login: $e");
      return Pasien(userId: 0, email: '', username: '', pasienId: 0, nama: '');
    }
  }
}
