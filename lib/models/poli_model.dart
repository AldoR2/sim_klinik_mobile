import 'dart:ui';

class PoliModel {
  final int? id;
  final String? nama;
  String? imagePath;
  Color? color;

  PoliModel({required this.id, required this.nama, this.imagePath, this.color});

  factory PoliModel.fromJson(Map<String, dynamic> json) {
    return PoliModel(id: json["id"], nama: json["nama"]);
  }
}
