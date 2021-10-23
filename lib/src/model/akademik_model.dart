class Prasyarat {
  String kodeMatkul;
  String namaMatkul;
  String semester;
  String sks;
  String syarat;

  Prasyarat(
      {this.kodeMatkul, this.namaMatkul, this.semester, this.sks, this.syarat});
  Prasyarat.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matkul'];
    namaMatkul = json['nama_matkul'];
    semester = json['semester'];
    sks = json['sks'];
    syarat = json['syarat'];
  }
}

class NonPrasyarat {
  String kodeMatkul;
  String namaMatkul;
  String semester;
  String sks;
  NonPrasyarat({this.kodeMatkul, this.namaMatkul, this.semester, this.sks});

  NonPrasyarat.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matkul'];
    namaMatkul = json['nama_matkul'];
    semester = json['semester'];
    sks = json['sks'];
  }
}

class PrasyaratModel {
  List<Prasyarat> prasyarat;
  List<NonPrasyarat> nonPrasyarat;
  String message;

  PrasyaratModel({this.prasyarat, this.nonPrasyarat});
  PrasyaratModel.fromJson(Map<String, dynamic> json) {
    if (json['prasyarat'] != null) {
      prasyarat = new List<Prasyarat>();
      json['prasyarat'].forEach((v) {
        prasyarat.add(new Prasyarat.fromJson(v));
      });
    }
    if (json['non_prasyarat'] != null) {
      nonPrasyarat = new List<NonPrasyarat>();
      json['non_prasyarat'].forEach((v) {
        nonPrasyarat.add(new NonPrasyarat.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Perwalian {
  String semester;
  String jam;
  String tanggal;
  String ruangan;

  Perwalian({this.semester, this.jam, this.tanggal, this.ruangan});
  Perwalian.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    jam = json['jam'];
    tanggal = json['tanggal'];
    ruangan = json['ruang'];
  }
}

class PerwalianModel {
  Perwalian perwalian;
  String message;

  PerwalianModel({this.perwalian, this.message});
  PerwalianModel.fromJson(Map<String, dynamic> json) {
    perwalian = json['perwalian'] != null
        ? new Perwalian.fromJson(json['perwalian'])
        : null;
    message = json['message'];
  }
}

class Polling {
  String kodeMatkul;
  String namaMatkul;
  String semester;
  String sks;

  Polling({this.kodeMatkul, this.namaMatkul, this.semester, this.sks});
  Polling.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matakuliah'];
    namaMatkul = json['nama_matakuliah'];
    semester = json['semester'];
    sks = json['sks'];
  }
}

class PollingModel {
  List<Polling> polling;
  String message;

  PollingModel({this.polling, this.message});
  PollingModel.fromJson(Map<String, dynamic> json) {
    if (json['polling'] != null) {
      polling = List<Polling>();
      json['polling'].forEach((v) {
        polling.add(Polling.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class SisaMatkul {
  String kodeMatkul;
  String namaMatkul;
  String semester;
  String sks;

  SisaMatkul({this.kodeMatkul, this.namaMatkul, this.semester, this.sks});
  SisaMatkul.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matkul'];
    namaMatkul = json['nama_matkul'];
    semester = json['semester'];
    sks = json['sks'];
  }
}

class SisaMatkulModel {
  List<SisaMatkul> sisaMatkul;
  String message;

  SisaMatkulModel({this.sisaMatkul, this.message});
  SisaMatkulModel.fromJson(Map<String, dynamic> json) {
    if (json['sisa_matkul'] != null) {
      sisaMatkul = List<SisaMatkul>();
      json['sisa_matkul'].forEach((v) {
        sisaMatkul.add(SisaMatkul.fromJson(v));
      });
    }
  }
}
