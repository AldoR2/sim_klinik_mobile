import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:sim_klinik_mobile/models/doctor_schedule_model.dart';
import 'package:sim_klinik_mobile/models/poli_model.dart';
import 'package:http/http.dart' as http;

class PracticeScheduleService extends GetxService {
  final _baseURL = "${ApiConstants.globalURL}features/practice";
  final Logger log = Logger();
  final GetStorage _box = GetStorage();

  Future<BaseResponse<List<PoliModel>>> fetchListPoli() async {
    try {
      final token = _box.read("auth_token");

      final url = Uri.parse("$_baseURL/list/poli");
      log.d(url);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
      );

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
        log.d(body);
        if (body['status'] == "success") {
          final List<dynamic> dataList = body['data'];

          final polis = dataList
              .map((item) => PoliModel.fromJson(item))
              .toList();

          return BaseResponse<List<PoliModel>>(
            status: body['status'],
            message: body['message'],
            data: polis,
          );
        } else {
          return BaseResponse(
            status: body['status'],
            message: body['message'],
            data: null,
          );
        }
      }

      return BaseResponse(
        status: "Error",
        message: "Terjadi kesalahan",
        data: null,
      );
    } catch (e) {
      log.f("Error: $e");
      return BaseResponse(status: "Error", message: "Terjadi kesalahan: $e");
    }
  }

  Future<BaseResponse<List<DoctorScheduleModel>>> fetchSchedulePoli(
    String id,
  ) async {
    try {
      final token = _box.read("auth_token");

      final url = Uri.parse("$_baseURL/list/scheduleDoctor?id_poli=$id");
      log.d(url);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
      );

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
        log.d(body);

        if (body['status'] == "success") {
          final List<dynamic> dataList = body['data'];

          final schedule = dataList
              .map((item) => DoctorScheduleModel.fromJson(item))
              .toList();

          return BaseResponse<List<DoctorScheduleModel>>(
            status: body['status'],
            message: body['message'],
            data: schedule,
          );
        } else {
          return BaseResponse(
            status: body['status'],
            message: body['message'],
            data: null,
          );
        }
      }

      return BaseResponse(
        status: "Error",
        message: "Terjadi kesalahan",
        data: null,
      );
    } catch (e) {
      log.f("Error: $e");
      return BaseResponse(status: "Error", message: "Terjadi kesalahan: $e");
    }
  }
}
