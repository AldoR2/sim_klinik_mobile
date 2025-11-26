class PoliModel {
  final int? id;
  final String? nama;

  PoliModel({required this.id, required this.nama});

  factory PoliModel.fromJson(Map<String, dynamic> json) {
    return PoliModel(id: json["id"], nama: json["nama"]);
  }
}
