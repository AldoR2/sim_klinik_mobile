import 'package:flutter/material.dart';

class DoctorModel {
  final String name;
  final String time;
  final String imagePath;

  DoctorModel({
    required this.name,
    required this.time,
    required this.imagePath,
  });
}

class DoctorScheduleModel {
  final String poliName;
  final List<DoctorModel> doctors;
  final String iconPath;
  final Color poliColor;

  DoctorScheduleModel({
    required this.poliName,
    required this.doctors,
    required this.iconPath,
    required this.poliColor,
  });

  // Getter otomatis menghitung jumlah dokter
  int get totalDoctor => doctors.length;
}
