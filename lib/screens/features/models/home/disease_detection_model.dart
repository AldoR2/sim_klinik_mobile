class DeteksiResultModel {
  final String diseaseName;
  final double accuracy;
  final List<String> recommendations;

  DeteksiResultModel({
    required this.diseaseName,
    required this.accuracy,
    required this.recommendations,
  });
}
