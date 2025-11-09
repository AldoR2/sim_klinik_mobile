import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordService extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}auth/forgetPassword";
  // final GetStorage _box = GetStorage();
  final global = ApiConstants.globalURL;
  final Logger log = Logger();

  Future<BaseResponse> fetchEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseURL"),
        body: {'email': email},
        headers: {"Accept": "application/json"},
      );
      log.d(_baseURL);

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
      log.e("Error during forget password: $e");
    }
    return BaseResponse(
      status: "error",
      message: "Terjadi kesalahan saat forget password",
    );
  }

  Future<BaseResponse> sendOTP(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseURL/verification/send"),
        body: {'email': email},
        headers: {"Accept": "application/json"},
      );
      log.d(_baseURL);

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
      log.e("Error during forget password: $e");
    }
    return BaseResponse(
      status: "error",
      message: "Terjadi kesalahan saat forget password",
    );
  }

  Future<BaseResponse> checkOTP(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseURL/verification/check"),
        body: {'email': email, 'token': otp},
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['status'] == 'success') {
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
      log.e("Error during checking otp: $e");
    }
    return BaseResponse(
      status: "error",
      message: "Terjadi kesalahan saat registrasi",
    );
  }

  Future<BaseResponse> fetchPassword(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseURL/changePassword"),
        body: {'email': email, 'password': password},
        headers: {"Accept": "application/json"},
      );
      log.d(_baseURL);

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
      log.e("Error during forget password: $e");
    }
    return BaseResponse(
      status: "error",
      message: "Terjadi kesalahan saat lupa password",
    );
  }
}
