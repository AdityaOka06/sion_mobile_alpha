class Mahasiswa {
  String nama;
  String nim;
  String prodi;
  String status;

  Mahasiswa({this.nama, this.nim, this.prodi, this.status});
  Mahasiswa.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nim = json['nim'];
    prodi = json['prodi'];
    status = json['status'];
  }
}

class MahasiswaModel {
  List<Mahasiswa> mahasiswa;
  String message;

  MahasiswaModel({this.mahasiswa, this.message});
  MahasiswaModel.fromJson(Map<String, dynamic> json) {
    if (json['mahasiswa'] != null) {
      mahasiswa = List<Mahasiswa>();
      json['mahasiswa'].forEach((v) {
        mahasiswa.add(Mahasiswa.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Dosen {
  String nama;
  String jurusan;
  String alamat;
  String telepon;
  String email;

  Dosen({this.nama, this.jurusan, this.alamat, this.email, this.telepon});
  Dosen.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jurusan = json['jurusan'];
    alamat = json['alamat'];
    telepon = json['nomor_hp'];
    email = json['email'];
  }
}

class DosenModel {
  List<Dosen> dosen;
  String message;

  DosenModel({this.dosen, this.message});
  DosenModel.fromJson(Map<String, dynamic> json) {
    if (json['dosen'] != null) {
      dosen = List<Dosen>();
      json['dosen'].forEach((v) {
        dosen.add(Dosen.fromJson(v));
      });
    }
    message = json['message'];
  }
}
