class Pengumuman {
  String prioritas;
  String judul;
  String pengumuman;
  String fileName;
  String dirUpload;

  Pengumuman(
      {this.prioritas,
      this.judul,
      this.pengumuman,
      this.fileName,
      this.dirUpload});
  Pengumuman.fromJson(Map<String, dynamic> json) {
    prioritas = json['prioritas'];
    judul = json['judul'];
    pengumuman = json['pengumuman'];
    fileName = json['filename'];
    dirUpload = json['dirupload'];
  }
}

class PengumumanModel {
  List<Pengumuman> pengumuman;
  String message;

  PengumumanModel({this.pengumuman, this.message});

  PengumumanModel.fromJson(Map<String, dynamic> json) {
    if (json['pengumuman'] != null) {
      pengumuman = List<Pengumuman>();
      json['pengumuman'].forEach((v) {
        pengumuman.add(Pengumuman.fromJson(v));
      });
      message = json['message'];
    }
  }
}
