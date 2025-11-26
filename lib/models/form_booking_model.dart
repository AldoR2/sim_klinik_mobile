class FormBookingModel {
  final int? pasienId;
  final int? poliId;
  final int? dokterId;
  final String? jamAwal;
  final String? jamAkhir;
  final String? tglKunjungan;
  final String? keluhanAwal;

  FormBookingModel({
    required this.pasienId,
    required this.poliId,
    required this.dokterId,
    required this.jamAwal,
    required this.jamAkhir,
    required this.tglKunjungan,
    required this.keluhanAwal,
  });

  factory FormBookingModel.fromJson(Map<String, dynamic> json) {
    return FormBookingModel(
      pasienId: json["pasien_id"],
      poliId: json["poli_id"],
      dokterId: json["dokter_id"],
      jamAwal: json["jam_awal"],
      jamAkhir: json["jam_akhir"],
      tglKunjungan: json["tgl_kunjungan"],
      keluhanAwal: json["keluhan_awal"],
    );
  }

  Map<String, dynamic> toJson() => {
    "pasien_id": pasienId.toString(),
    "poli_id": poliId.toString(),
    "dokter_id": dokterId.toString(),
    "jam_awal": jamAwal.toString(),
    "jam_akhir": jamAkhir.toString(),
    "tgl_kunjungan": tglKunjungan.toString(),
    "keluhan_awal": keluhanAwal.toString(),
  };
}
