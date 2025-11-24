import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';
import 'package:sim_klinik_mobile/models/base_response.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:sim_klinik_mobile/models/disease_prediction_model.dart';

class DiseaseDetectionServices extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}features/disease-detection";
  final GetStorage _box = GetStorage();
  final global = ApiConstants.globalURL;
  final Logger log = Logger();

  Future<BaseResponse<DiseasePredictionModel>> fetchPrediction(
    File? image,
    String ext,
  ) async {
    try {
      final token = await _box.read("auth_token");

      final url = Uri.parse(_baseURL);
      log.d(url);

      final request = http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Accept': 'application/json', // Header Accept
        'Authorization': 'Bearer $token', // Header Authorization
      });

      if (image != null) {
        final contentType = getContentTypeFromExtension(ext);
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          image.path,
          filename: path.basename(image.path),
          contentType: contentType,
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();

      final respStr = await http.Response.fromStream(response);
      log.d(respStr.body);

      if (response.statusCode == 401) {
        Get.snackbar("Gagal", "Lakukan login kembali, waktu token telah habis");
        Get.offAllNamed("/auth/login");
        return BaseResponse(
          status: "error",
          message: "Gagal terhubung ke server",
        );
      }

      final body = jsonDecode(respStr.body);
      log.d(body);

      return BaseResponse.fromJson(
        body,
        (dataJson) => DiseasePredictionModel.fromJson(dataJson),
      );
    } catch (e) {
      log.f("Error: $e");
      return BaseResponse(
        status: "Error",
        message: "Terjadi kesalahan $e",
        data: null,
      );
    }
  }

  MediaType? getContentTypeFromExtension(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'docx':
        return MediaType(
          'application',
          'vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
      default:
        return null;
    }
  }
}
