import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/base/booking_form_controller.dart';
import 'package:sim_klinik_mobile/models/poli_model.dart';
import 'package:sim_klinik_mobile/models/sesi_model.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';
import 'package:sim_klinik_mobile/screens/reusables/loading_screen.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _controller = Get.find<BookingFormController>();
  // Controllers

  // Dropdown variables
  // String? selectedPoli;
  // String? selectedBulan;
  // String? selectedTanggal;
  // String? selectedSesi;

  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Form Antrian"),
          const SizedBox(height: 12),

          // Expanded agar form bisa scroll + button tetap di bawah
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================== Nama =====================

                  // =================== Poli =====================
                  _buildLabel('Pilih Poli *', width),
                  SizedBox(height: 6),
                  Obx(() {
                    return dropdownBox<PoliModel>(
                      hint: "Pilih poli",
                      value: _controller.selectedPoli.value,
                      items: _controller.listPoli.toList(),
                      labelBuilder: (item) => item.nama!, // tampilkan nama
                      onChanged: (val) {
                        _controller.selectedPoli.value = val;
                        _controller.fetchSesi();
                      },
                    );
                  }),
                  SizedBox(height: 16),

                  // =================== Tanggal Berobat =====================
                  _buildLabel('Tanggal Berobat *', width),
                  SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Obx(() {
                          final bulanValue = _controller.selectedBulan.value;
                          final bulanItems = _controller.jumlahHariPerBulan.keys
                              .toList();

                          return dropdownBox(
                            // BULAN
                            labelBuilder: (item) => item,
                            hint: "Bulan",
                            value:
                                bulanValue != null &&
                                    bulanItems.contains(bulanValue)
                                ? bulanValue
                                : null,
                            items: bulanItems,
                            onChanged: (val) {
                              _controller.selectedBulan.value = val;
                              _controller.selectedTanggal.value = null;
                            },
                          );
                        }),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        flex: 3,
                        child: Obx(() {
                          final tanggalItems =
                              _controller.selectedBulan.value == null
                              ? []
                              : _controller.getTanggalList(
                                  _controller.selectedBulan.value!,
                                );
                          return dropdownBox(
                            // TANGGAL
                            labelBuilder: (item) => item,
                            hint: "Tanggal",
                            value:
                                tanggalItems.contains(
                                  _controller.selectedTanggal.value,
                                )
                                ? _controller.selectedTanggal.value
                                : null,
                            items: tanggalItems,
                            onChanged: (val) {
                              _controller.selectedTanggal.value = val;
                              _controller.getHari();
                              _controller.fetchSesi();
                            },
                          );
                        }),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        flex: 2,
                        child: dropdownBox(
                          // TAHUN
                          labelBuilder: (item) => item,

                          value: currentYear.toString(),
                          items: [currentYear.toString()],
                          enabled: false,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // =================== Sesi =====================
                  _buildLabel('Pilih Sesi *', width),
                  SizedBox(height: 6),
                  Obx(() {
                    final sesiItems = _controller.listSesi;
                    return dropdownBox<SesiModel>(
                      hint: "Pilih sesi",
                      labelBuilder: (item) =>
                          item.jamMulai + " - " + item.jamSelesai,
                      value: sesiItems.contains(_controller.selectedSesi.value)
                          ? _controller.selectedSesi.value
                          : null,
                      items: sesiItems,
                      onChanged: (val) {
                        _controller.selectedSesi.value = val;
                        _controller.selectedDoctor.value = val!.idDokter;
                        _controller.fetchKeterangan();
                      },
                    );
                  }),
                  SizedBox(height: 16),

                  // =================== Keterangan Dokter (DISABLED) =====================
                  _buildLabel('Keterangan Dokter', width),
                  SizedBox(height: 6),

                  TextField(
                    controller: _controller.keteranganDokterController,
                    enabled: false,
                    maxLines: 2,
                    decoration: inputDecoration("Dokter akan tampil otomatis"),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // =================== BUTTON DI BAWAH =====================
          Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.035),
              color: Color(0xFF7134FC),
            ),
            child: TextButton(
              onPressed: () async {
                final width = MediaQuery.of(context).size.width;

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: width * 0.85,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Close Button (kanan atas)
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: width * 0.065,
                                ),
                              ),
                            ),
                            SizedBox(height: 6),

                            // Title
                            Text(
                              "Konfirmasi Pesanan",
                              style: TextStyle(
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),

                            // Subtitle
                            Text(
                              "Apakah anda yakin data yang diisi sudah benar?",
                              style: TextStyle(
                                fontSize: width * 0.043,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 22),

                            // Tombol Save dan Delete — Full Width
                            Row(
                              children: [
                                // Cancel
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Batal",
                                        style: TextStyle(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),

                                // Confirm
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_controller.isSnackbarOpen.value ==
                                          false)
                                        await _controller.submit();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF7134FC),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Pesan",
                                        style: TextStyle(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

              child: Padding(
                padding: EdgeInsets.symmetric(vertical: width * 0),
                child: Text(
                  "Pesan Antrian",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // CUSTOM WIDGETS
  // ===========================================================

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget dropdownBox<T>({
    String? hint,
    T? value,
    required List<T> items,
    required String Function(T) labelBuilder, // convert item -> text

    bool enabled = true,
    void Function(T?)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButton<T>(
        hint: Text(hint ?? ""),
        value: value,
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(labelBuilder(item)), // tampilkan label
              ),
            )
            .toList(),
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}

Widget _buildLabel(String label, double w) {
  // Pisahkan teks utama dan tanda *
  final parts = label.split('*');
  final mainText = parts[0].trim();
  final hasAsterisk = label.contains('*');

  return SingleChildScrollView(
    child: Align(
      alignment: Alignment.centerLeft, // 🔹 memastikan teks rata kiri
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: w * 0.04,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(text: mainText),
            if (hasAsterisk)
              TextSpan(
                text: ' *',
                style: TextStyle(color: Color(0xFFB30000)),
              ),
          ],
        ),
      ),
    ),
  );
}
