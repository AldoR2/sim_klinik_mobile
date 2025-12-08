import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:sim_klinik_mobile/models/doctor_model.dart';
import 'package:sim_klinik_mobile/models/schedule_doctor_model.dart';
import 'package:http/http.dart' as http;

class DashboardService extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}home";
  final String global = "${ApiConstants.globalURL}";
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  Future<BaseResponse<List<ScheduleDoctorModel>>> fetchScheduleDoctor() async {
    try {
      final token = await _box.read("auth_token");

      final url = Uri.parse("$_baseURL/list/scheduleDoctor");
      log.d(url);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
      );
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
          final List<dynamic> dataList = body['data'];

          final schedules = dataList
              .map((item) => ScheduleDoctorModel.fromJson(item))
              .toList();

          final doctorRespons = await fetchListDoctor();
          final doctors = doctorRespons.data ?? [];

          for (var schedule in schedules) {
            schedule.doctors = doctors
                .where((d) => d.id == schedule.dokterId)
                .toList();
          }

          return BaseResponse<List<ScheduleDoctorModel>>(
            status: body['status'],
            message: body['message'],
            data: schedules,
          );
        } else {
          return BaseResponse(
            status: body['status'],
            message: body['message'],
            data: null,
          );
        }
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(
          status: body['status'],
          message: body['message'],
          data: null,
        );
      }
    } catch (e) {}
    log.e("Error during fetch schedule dashboard: $e");
    return BaseResponse(
      status: "error",
      message: "Terjadi kesalahan saat mengecek jadwal dashboard",
      data: null,
    );
  }

  Future<BaseResponse<List<DoctorModel>>> fetchListDoctor() async {
    try {
      final token = await _box.read("auth_token");

      final url = Uri.parse("${global}features/list/dashboard/doctor");
      log.d(url);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
      );
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

          final List<dynamic> dataList = body['data'];

          final doctors = dataList
              .map((item) => DoctorModel.fromJson(item))
              .toList();

          return BaseResponse(
            status: body['status'],
            message: body['message'],
            data: doctors,
          );
        } else {
          return BaseResponse(
            status: body['status'],
            message: body['message'],
            data: null,
          );
        }
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(
          status: body['status'],
          message: body['message'],
          data: null,
        );
      }
    } catch (e) {
      log.e("Error during fetch list doctor: $e");
      return BaseResponse(
        status: "error",
        message: "Terjadi kesalahan saat mengecek list dokter",
      );
    }
  }
}
