class Pasien {
  final int? userId;
  final String? email;
  final String? username;
  final int? pasienId;
  final String? nama;
  final String? status;
  final String? message;

  Pasien({
    required this.userId,
    required this.email,
    required this.username,
    required this.pasienId,
    required this.nama,
    this.status,
    this.message,
  });

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      userId: json["user_id"],
      email: json["email"],
      username: json["username"],
      pasienId: json["pasien_id"],
      nama: json["nama"],
      status: json['status'],
      message: json['message'],
    );
  }
}
