import 'package:flutter/material.dart';
import 'package:sim_klinik_mobile/models/doctor_model.dart';

class ScheduleDoctorModel {
  final int? id;
  final int? dokterId;
  final int? poliId;
  final String? hari;
  final String? jamMulai;
  final String? jamAkhir;
  final String? keterangan;
  final String? namaPoli;
  List<DoctorModel>? doctors;

  ScheduleDoctorModel({
    required this.id,
    required this.dokterId,
    required this.poliId,
    required this.hari,
    required this.jamMulai,
    required this.jamAkhir,
    required this.keterangan,
    this.namaPoli,
    this.doctors,
  });

  factory ScheduleDoctorModel.fromJson(Map<String, dynamic> json) {
    return ScheduleDoctorModel(
      id: json["id"],
      dokterId: json["dokter_id"],
      poliId: json["poli_id"],
      hari: json["hari"],
      jamMulai: json["jam_mulai"],
      jamAkhir: json["jam_akhir"],
      keterangan: json["keterangan"],
      namaPoli: json["nama_poli"],
    );
  }

  String get iconPath {
    switch (poliId) {
      case 1:
        return "assets/icons/ic_poli_gigi.png";
      case 2:
        return "assets/icons/ic_poli_umum.png";
      default:
        return "assets/icons/ic_default.png";
    }
  }

  Color get poliColor {
    switch (poliId) {
      case 1:
        return const Color(0xFF2088FF); // warna poli gigi
      case 2:
        return const Color(0xFF1DBF73); // warna poli umum
      default:
        return Colors.grey;
    }
  }

  int get totalDoctor => doctors?.length ?? 0;
}
