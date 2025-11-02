class DetailScheduleModel {
  final String doctorName;
  final String doctorImage;
  final String time;
  final String spesialisasi;
  final List<String> practiceDays;

  DetailScheduleModel({
    required this.doctorName,
    required this.doctorImage,
    required this.time,
    required this.spesialisasi,
    required this.practiceDays,
  });
}
