import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class DashboardController extends GetxController {
  final GetStorage _box = GetStorage();
  final Logger log = Logger();
  var isLoading = true.obs;
  var data = {}.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
    final username = _box.read("username");
    data.addAll({"username": username});
    fetchDashboad();
  }

  Future<void> fetchDashboad() async {}
}
