class DoctorScheduleModel {
  final String idDokter;
  final String doctorName;
  final String? doctorImage;
  final String time;
  final List<String> practiceDays;
  final String spesialisasi;

  DoctorScheduleModel({
    required this.idDokter,
    required this.doctorName,
    required this.doctorImage,
    required this.time,
    required this.practiceDays,
    required this.spesialisasi,
  });

  factory DoctorScheduleModel.fromJson(Map<String, dynamic> json) {
    return DoctorScheduleModel(
      idDokter: json['dokter_id'].toString(),
      doctorName: json['nama_dokter'] ?? '-',
      doctorImage: json['foto_dokter'] ?? 'assets/images/default profile.png',
      time: _formatTime(json['jam_mulai'], json['jam_akhir']),
      practiceDays: [json['hari'] ?? '-'],
      spesialisasi: json['spesialisasi'] ?? '-',
    );
  }

  static String _formatTime(String? start, String? end) {
    if (start == null || end == null) return '-';

    final startShort = start.substring(0, 5);
    final endShort = end.substring(0, 5);

    return '$startShort - $endShort';
  }
}
