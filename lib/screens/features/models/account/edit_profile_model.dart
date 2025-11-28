class EditProfileModel {
  String nama;
  String email;
  String fotoProfil;
  bool isEmailVerified; // ⬅ status baru

  EditProfileModel({
    required this.nama,
    required this.email,
    required this.fotoProfil,
    this.isEmailVerified = false, // default tidak terdaftar
  });
}
