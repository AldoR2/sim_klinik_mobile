import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:http/http.dart' as http;
import 'package:sim_klinik_mobile/models/doctor_model.dart';
import 'package:sim_klinik_mobile/models/form_booking_model.dart';
import 'package:sim_klinik_mobile/models/poli_model.dart';
import 'package:sim_klinik_mobile/models/schedule_doctor_model.dart';

class BookingFormService extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}features";
  final GetStorage _box = GetStorage();
  final Logger log = Logger();

  Future<BaseResponse> fetchBooking(FormBookingModel formbookingModel) async {
    try {
      final token = await _box.read("auth_token");

      final url = Uri.parse("$_baseURL/add-booking");
      log.d(url);

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // Header Authorization
        },
        body: formbookingModel.toJson(),
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
          return BaseResponse(status: body['status'], message: body['message']);
        } else {
          return BaseResponse(status: body['status'], message: body['message']);
        }
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(status: body['status'], message: body['message']);
      }
    } catch (e) {
      log.f("Error: $e");
      return BaseResponse(
        status: "Error",
        message: "Terjadi kesalahan $e",
        data: null,
      );
    }
  }

  Future<BaseResponse<List<PoliModel>>> fetchListPoli() async {
    try {
      final token = await _box.read("auth_token");

      final url = Uri.parse("$_baseURL/list/poli");
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
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(
          status: body['status'],
          message: body['message'],
          data: null,
        );
      }
    } catch (e) {
      log.e("Error during fetch list poli: $e");
      return BaseResponse(
        status: "error",
        message: "Terjadi kesalahan saat mengecek list poli",
      );
    }
  }

  Future<BaseResponse<List<DoctorModel>>> fetchListDoctor() async {
    try {
      final token = await _box.read("auth_token");

      final url = Uri.parse("$_baseURL/list/dashboard/doctor");
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
          log.d(body);

          final List<dynamic> dataList = body['data'];

          final schedule = dataList
              .map((item) => ScheduleDoctorModel.fromJson(item))
              .toList();

          return BaseResponse<List<ScheduleDoctorModel>>(
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
      } else {
        final body = jsonDecode(response.body);
        return BaseResponse(
          status: body['status'],
          message: body['message'],
          data: null,
        );
      }
    } catch (e) {
      log.e("Error during fetch list schedule doctor: $e");
      return BaseResponse(
        status: "error",
        message: "Terjadi kesalahan saat mengecek list jadwal dokter",
      );
    }
  }
}
