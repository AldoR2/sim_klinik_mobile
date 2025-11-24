import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/base/booking_form_controller.dart';

class BookingFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingFormController());
  }
}
