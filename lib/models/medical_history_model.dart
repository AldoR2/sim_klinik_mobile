import 'package:intl/intl.dart';

class MedicalHistoryModel {
  final int? id;
  final String? status;
  final String? namaPoli;
  final String? jamAwal;
  final String? jamAkhir;
  final String? tglKunjungan;
  final String? namaPasien;
  final String? namaDokter;
  final String? pemesanan;

  MedicalHistoryModel({
    required this.id,
    required this.status,
    required this.namaPoli,
    required this.jamAwal,
    required this.jamAkhir,
    required this.tglKunjungan,
    required this.namaPasien,
    required this.namaDokter,
    required this.pemesanan,
  });

  factory MedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    return MedicalHistoryModel(
      id: json["id"],
      status: capitalize(json["status"]),
      namaPoli: json["nama_poli"],
      jamAwal: json["jam_awal"],
      jamAkhir: json["jam_akhir"],
      tglKunjungan: _formatTanggal(json["tgl_kunjungan"]),
      namaPasien: json["nama_pasien"],
      namaDokter: json["nama_dokter"],
      pemesanan: "Pemesanan Via Klinik / Aplikasi",
    );
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String _formatTanggal(String? tanggal) {
    if (tanggal == null || tanggal.isEmpty) return "-";

    try {
      final parsed = DateTime.parse(tanggal);

      final formatter = DateFormat("EEEE, d MMMM yyyy", "id_ID");
      return formatter.format(parsed);
    } catch (e) {
      return tanggal;
    }
  }
}
