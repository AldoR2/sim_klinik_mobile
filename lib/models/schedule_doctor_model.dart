class ScheduleDoctorModel {
  final int? id;
  final int? dokterId;
  final int? poliId;
  final String? hari;
  final String? jamMulai;
  final String? jamAkhir;
  final String? keterangan;
  
  ScheduleDoctorModel({
    required this.id,
    required this.dokterId,
    required this.poliId,
    required this.hari,
    required this.jamMulai,
    required this.jamAkhir,
    required this.keterangan,
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
    );
  }
}
