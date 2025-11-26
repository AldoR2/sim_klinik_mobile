class DoctorModel {
  final int? id;
  final String? nama;

  DoctorModel({required this.id, required this.nama});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(id: json["id"], nama: json["nama"]);
  }
}
