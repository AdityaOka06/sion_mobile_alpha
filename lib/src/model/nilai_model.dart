class Ip {
  String semester;
  String ipSemester;
  String ipKumulatif;
  String sksSemester;
  String sksKumulatif;

  Ip(
      {this.semester,
      this.ipSemester,
      this.ipKumulatif,
      this.sksSemester,
      this.sksKumulatif});

  Ip.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    ipSemester = json['ip_semester'];
    ipKumulatif = json['ip_kumulatif'];
    sksSemester = json['sks_semester'];
    sksKumulatif = json['sks_kumulatif'];
  }
}

class IpModel {
  List<Ip> ip;
  String message;

  IpModel({this.ip, this.message});

  IpModel.fromJson(Map<String, dynamic> json) {
    if (json['ip'] != null) {
      ip = List<Ip>();
      json['ip'].forEach((v) {
        ip.add(Ip.fromJson(v));
      });
    }
    message = json['message'];
  }
}

// class HasilUjian {
//   String kodeKuliah;
//   String namaKuliah;
//   String semester;
//   String kuis;
//   String tugas;
//   String uts;
//   String uas;
//   String nilaiAkhir;
//   String nh;

//   HasilUjian(
//       {this.kodeKuliah,
//       this.namaKuliah,
//       this.semester,
//       this.kuis,
//       this.tugas,
//       this.uts,
//       this.uas,
//       this.nilaiAkhir,
//       this.nh});

//   HasilUjian.fromJson(Map<String, dynamic> json) {
//     kodeKuliah = json['kode_kuliah'];
//     namaKuliah = json['nama_kuliah'];
//     semester = json['semester1'];
//     kuis = json['kuis'];
//     tugas = json['tugas'];
//     uts = json['uts'];
//     nilaiAkhir = json['nilai_akhir'];
//     nh = json['nilai_nah'];
//   }
// }

// class HasilUjianModel {
//   List<HasilUjian> hasilUjian;
//   String message;

//   HasilUjianModel(this.hasilUjian, this.message);
//   HasilUjianModel.fromJson(Map<String, dynamic> json) {
//     if (json['hasil_ujian'] != null) {
//       hasilUjian = List<HasilUjian>();
//       json['hasil_ujian'].forEach((v) {
//         hasilUjian.add(HasilUjian.fromJson(v));
//       });
//     }
//     message = json['meesage'];
//   }
// }

class Transkrip {
  String semester;
  String kodeMatakuliah;
  String namaMatakuliah;
  String sks;
  String nh;

  Transkrip(
      {this.semester,
      this.kodeMatakuliah,
      this.namaMatakuliah,
      this.sks,
      this.nh});
  Transkrip.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    namaMatakuliah = json['nama_matakuliah'];
    kodeMatakuliah = json['kode_matakuliah'];
    sks = json['sks'];
    nh = json['nh'];
  }
}

class TranskripModel {
  List<Transkrip> transkrip;
  String message;

  TranskripModel({this.transkrip, this.message});
  TranskripModel.fromJson(Map<String, dynamic> json) {
    if (json['transkrip'] != null) {
      transkrip = List<Transkrip>();
      json['transkrip'].forEach((v) {
        transkrip.add(Transkrip.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Histori {
  String kodeMatakuliah;
  String namaMatakuliah;
  String tugas;
  String kuis;
  String uts;
  String uas;
  String na;
  String nh;
  String semester;

  Histori(
      {this.kodeMatakuliah,
      this.namaMatakuliah,
      this.tugas,
      this.kuis,
      this.uts,
      this.uas,
      this.na,
      this.nh,
      this.semester});

  Histori.fromJson(Map<String, dynamic> json) {
    kodeMatakuliah = json['kode_kuliah'];
    namaMatakuliah = json['nama_matakuliah'];
    tugas = json['tugas'];
    kuis = json['kuis'];
    uts = json['uts'];
    uas = json['uas'];
    na = json['na'];
    nh = json['nh'];
    semester = json['semester'];
  }
}

class HistoriModel {
  List<Histori> histori;
  String message;

  HistoriModel({this.histori, this.message});
  HistoriModel.fromJson(Map<String, dynamic> json) {
    if (json['histori'] != null) {
      histori = List<Histori>();
      json['histori'].forEach((v) => histori.add(Histori.fromJson(v)));
    }
    message = json['message'];
  }
}
