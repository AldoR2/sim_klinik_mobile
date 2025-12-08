import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:sim_klinik_mobile/models/medical_history_model.dart';

class MedicalHistoryService extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}features";
  final GetStorage _box = GetStorage();
  final global = ApiConstants.globalURL;
  final Logger log = Logger();

  Future<BaseResponse<List<MedicalHistoryModel>>> fetchMedicalHistory(
    String id,
  ) async {
    try {
      final token = _box.read("auth_token");

      final url = Uri.parse("$_baseURL/history/listHistory?pasien_id=$id");
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

          final history = dataList
              .map((item) => MedicalHistoryModel.fromJson(item))
              .toList();

          return BaseResponse<List<MedicalHistoryModel>>(
            status: body['status'],
            message: body['message'],
            data: history,
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
