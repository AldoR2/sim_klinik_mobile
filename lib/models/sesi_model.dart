class SesiModel {
  final int id;
  final String jamMulai;
  final String jamSelesai;
  final int idDokter;

  SesiModel({
    required this.id,
    required this.jamMulai,
    required this.jamSelesai,
    required this.idDokter,
  });

  factory SesiModel.fromJson(Map<String, dynamic> json) {
    return SesiModel(
      id: json['id'],
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      idDokter: json['id_dokter'],
    );
  }
}
