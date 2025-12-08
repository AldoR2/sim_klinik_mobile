class DoctorModel {
  final int? id;
  final String? nama;
  final String? imagePath;
  final String? time;

  DoctorModel({
    required this.id,
    required this.nama,
    this.imagePath,
    this.time,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json["id"],
      nama: json["nama"],
      time: json['time'] ?? "",
    );
  }
}
