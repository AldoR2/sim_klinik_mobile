import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:http/http.dart' as http;

class ChangePasswordService {
  final String _baseURL = "${ApiConstants.globalURL}account/changePassword";
  final GetStorage _box = GetStorage();
  final global = ApiConstants.globalURL;
  final Logger log = Logger();

  Future<BaseResponse> checkPassword(String email, String password) async {
    try {
      final token = await _box.read("auth_token");

      final response = await http.post(
        Uri.parse("${global}account/checkPassword"),
        body: {'email': email, 'password': password},
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
      );
      log.d(global);
      log.d("Response code: ${response.statusCode}");
      log.d(response.body);

      if (response.statusCode == 401) {
        Get.snackbar("Gagal", "Lakukan login kembali, waktu token telah habis");
        Get.offAllNamed("/auth/login");
        return BaseResponse(
          status: "error",
          message: "Gagal terhubung ke server",
        );
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['status'] == "success") {
          log.d(body);
          return BaseResponse(status: body['status'], message: body['message']);
        } else {
          return BaseResponse(status: body['status'], message: body['message']);
        }
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(status: body['status'], message: body['message']);
      }
    } catch (e) {
      log.e("Error during checking password: $e");
      return BaseResponse(
        status: "error",
        message: "Terjadi kesalahan saat mengecek password",
      );
    }
  }

  Future<BaseResponse> changePassword(String email, String password) async {
    try {
      final token = await _box.read("auth_token");

      final response = await http.post(
        Uri.parse("$_baseURL"),
        body: {'email': email, 'new_password': password},
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
      );
      log.d(_baseURL);

      if (response.statusCode == 401) {
        Get.snackbar("Gagal", "Lakukan login kembali, waktu token telah habis");
        Get.offAllNamed("/auth/login");
        return BaseResponse(
          status: "error",
          message: "Gagal terhubung ke server",
        );
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['status'] == "success") {
          log.d(body);
          return BaseResponse(status: body['status'], message: body['message']);
        } else {
          return BaseResponse(status: body['status'], message: body['message']);
        }
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(status: body['status'], message: body['message']);
      }
    } catch (e) {
      log.e("Error during change password: $e");
    }
    return BaseResponse(
      status: "error",
      message: "Terjadi kesalahan saat mengubah password",
    );
  }
}
