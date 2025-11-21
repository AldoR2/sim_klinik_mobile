class DiseasePredictionModel {
    final int? classId;
    final double? confidence;
    final double? inferenceTimeMs;

    DiseasePredictionModel({
        required this.classId,
        required this.confidence,
        required this.inferenceTimeMs,
    });

    factory DiseasePredictionModel.fromJson(Map<String, dynamic> json){ 
        return DiseasePredictionModel(
            classId: json["class_id"],
            confidence: json["confidence"],
            inferenceTimeMs: json["inference_time_ms"],
        );
    }

}
