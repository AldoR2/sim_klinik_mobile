import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sim_klinik_mobile/constants/api.dart';

class DiseaseDetectionServices extends GetxService {
  final String _baseURL = "${ApiConstants.globalURL}features/disease-detection";
  // final GetStorage _box = GetStorage();
  final global = ApiConstants.globalURL;
  final Logger log = Logger();
}
