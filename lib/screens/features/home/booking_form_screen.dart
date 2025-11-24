import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sim_klinik_mobile/controllers/base/booking_form_controller.dart';
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
  String? selectedPoli;
  String? selectedBulan;
  String? selectedTanggal;
  String? selectedSesi;

  int currentYear = DateTime.now().year;

  List<String> listPoli = [
    "Poli Umum",
    "Poli Gigi",
    "Poli Ibu dan Anak",
    "Poli Gizi",
  ];

  List<String> listSesi = ["07.00 - 09.00", "09.00 - 11.00", "13.00 - 15.00"];

  Map<String, int> jumlahHariPerBulan = {
    "Januari": 31,
    "Februari": 29, // Asumsikan tahun kabisat biar aman
    "Maret": 31,
    "April": 30,
    "Mei": 31,
    "Juni": 30,
    "Juli": 31,
    "Agustus": 31,
    "September": 30,
    "Oktober": 31,
    "November": 30,
    "Desember": 31,
  };

  List<String> getTanggalList(String bulan) {
    int total = jumlahHariPerBulan[bulan]!;
    return List.generate(total, (i) => (i + 1).toString());
  }

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
                  _buildLabel('Nama Lengkap *', width),
                  SizedBox(height: 6),
                  TextField(
                    controller: _controller.namaController,
                    decoration: inputDecoration("Masukkan nama lengkap"),
                  ),
                  SizedBox(height: 16),

                  // =================== Nomor HP =====================
                  _buildLabel('Nomor Handphone *', width),
                  SizedBox(height: 6),
                  TextField(
                    controller: _controller.hpController,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration("Masukkan nomor handphone"),
                  ),
                  SizedBox(height: 16),

                  // =================== Poli =====================
                  _buildLabel('Pilih Poli *', width),
                  SizedBox(height: 6),
                  dropdownBox(
                    hint: "Pilih poli",
                    value: selectedPoli,
                    items: listPoli,
                    onChanged: (val) {
                      setState(() => selectedPoli = val);
                    },
                  ),
                  SizedBox(height: 16),

                  // =================== Tanggal Berobat =====================
                  _buildLabel('Tanggal Berobat *', width),
                  SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: dropdownBox(
                          // BULAN
                          hint: "Bulan",
                          value: selectedBulan,
                          items: jumlahHariPerBulan.keys.toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedBulan = val;
                              selectedTanggal = null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        flex: 3,
                        child: dropdownBox(
                          // TANGGAL
                          hint: "Tanggal",
                          value: selectedTanggal,
                          items: selectedBulan == null
                              ? []
                              : getTanggalList(selectedBulan!),
                          onChanged: selectedBulan == null
                              ? null
                              : (val) {
                                  setState(() {
                                    selectedTanggal = val;
                                  });
                                },
                        ),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        flex: 2,
                        child: dropdownBox(
                          // TAHUN
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
                  dropdownBox(
                    hint: "Pilih sesi",
                    value: selectedSesi,
                    items: listSesi,
                    onChanged: (val) {
                      setState(() => selectedSesi = val);
                    },
                  ),
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
                                      Navigator.pop(context);
                                      Get.dialog(
                                        LoadingPopup(),
                                        barrierDismissible: false,
                                      );

                                      await Future.delayed(
                                        Duration(seconds: 2),
                                      );

                                      Get.back();
                                      Get.toNamed('/');
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

  Widget dropdownBox({
    String? hint,
    String? value,
    required List<String> items,
    bool enabled = true,
    void Function(String?)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButton<String>(
        hint: Text(hint ?? ""),
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
