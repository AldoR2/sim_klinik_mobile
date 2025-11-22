class DiseasePredictionModel {
  final int classId;
  final double confidence;
  final double inferenceTimeMs;
  final List<String> recommendations;

  DiseasePredictionModel({
    required this.classId,
    required this.confidence,
    required this.inferenceTimeMs,
    required this.recommendations,
  });

  String get diseaseName {
    switch (classId) {
      case 0:
        return "Normal";
      case 1:
        return "Tinea Nigra";
      case 2:
        return "Tinea Ringworm";
      case 3:
        return "Tinea VersiColor";
      default:
        return "Unknown Disease";
    }
  }

  factory DiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    final prediction = json["prediction"];
    return DiseasePredictionModel(
      classId: prediction["class_id"],
      confidence: prediction["confidence"],
      inferenceTimeMs: prediction["inference_time_ms"],
      recommendations: List<String>.from(json["treatment"]),
    );
  }
}
