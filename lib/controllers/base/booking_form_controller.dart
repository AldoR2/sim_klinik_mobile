import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BookingFormController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController keteranganDokterController =
      TextEditingController(text: "Menunggu pilihan poli & sesi...");

}