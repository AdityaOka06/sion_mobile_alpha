class Biodata {
  String nim;
  String nama;
  String prodi;
  String jurusan;
  String dosenWali;
  String tanggalLahir;
  String tempatLahir;
  String alamat;
  String desa;
  String kecamatan;
  String kabupaten;
  String provinsi;
  String telpon;
  String ponsel;
  String email;
  String facebook;
  String twitter;
  String agama;
  String nmIbu;
  String nmAyah;

  Biodata(
      {this.nim,
      this.nama,
      this.prodi,
      this.jurusan,
      this.dosenWali,
      this.tanggalLahir,
      this.tempatLahir,
      this.alamat,
      this.desa,
      this.kecamatan,
      this.kabupaten,
      this.provinsi,
      this.telpon,
      this.ponsel,
      this.email,
      this.facebook,
      this.twitter,
      this.agama,
      this.nmAyah,
      this.nmIbu});

  Biodata.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    nama = json['nama'];
    prodi = json['prodi'];
    jurusan = json['nama_konsentrasi'];
    dosenWali = json['dosen_wali'];
    tanggalLahir = json['tanggal_lahir'];
    tempatLahir = json['tempat_lahir'];
    alamat = json['alamat'];
    desa = json['desa'];
    kecamatan = json['kecamatan'];
    kabupaten = json['kabupaten'];
    provinsi = json['provinsi'];
    telpon = json['telepon'];
    ponsel = json['ponsel'];
    email = json['email'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    agama = json['agama'];
    nmAyah = json['ayah'];
    nmIbu = json['ibu'];
  }
}

class BiodataModel {
  Biodata biodata;
  String message;

  BiodataModel({this.biodata, this.message});

  BiodataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    biodata =
        json['biodata'] != null ? Biodata.fromJson(json['biodata']) : null;
  }
}
