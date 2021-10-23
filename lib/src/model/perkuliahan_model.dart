import '../bloc/bloc_status.dart';

class Jadwal {
  String hari;
  String kodeMatkul;
  String namaMatkul;
  String kelas;
  String ruangan;
  String jam;
  String namaDosen;

  Jadwal(
      {this.hari,
      this.kodeMatkul,
      this.namaMatkul,
      this.kelas,
      this.jam,
      this.ruangan,
      this.namaDosen});
  Jadwal.fromJson(Map<String, dynamic> json) {
    hari = json['hari'];
    kodeMatkul = json['kode_matkul'];
    namaMatkul = json['nama_matkul'];
    kelas = json['kelas'];
    ruangan = json['ruang'];
    jam = json['jam'];
    namaDosen = json['nama_dosen'];
  }
}

class JadualModel {
  List<Jadwal> jadwal;
  String message;

  JadualModel({this.jadwal, this.message});
  JadualModel.fromJson(Map<String, dynamic> json) {
    if (json['jadwal_kuliah'] != null) {
      jadwal = List<Jadwal>();
      json['jadwal_kuliah'].forEach((v) {
        jadwal.add(Jadwal.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Krs {
  String kodeMatkul;
  String namaMatkul;
  String sks;
  String kodeKelas;
  String semester1;
  String semester2;
  String tahunAjar;

  Krs(
      {this.kodeMatkul,
      this.namaMatkul,
      this.sks,
      this.kodeKelas,
      this.semester1,
      this.semester2,
      this.tahunAjar});

  Krs.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matakuliah'];
    namaMatkul = json['nama_matakuliah'];
    sks = json['sks'];
    kodeKelas = json['kode_kelas'];
    semester1 = json['semester1'];
    semester2 = json['semester2'];
    tahunAjar = json['tahun_ajaran'];
  }
}

class KrsModel {
  List<Krs> krs;
  String message;

  KrsModel({this.krs, this.message});
  KrsModel.fromJson(Map<String, dynamic> json) {
    if (json['krs'] != null) {
      krs = List<Krs>();
      json['krs'].forEach((v) {
        krs.add(Krs.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class JadwalSemester {
  BlocStatus<JadualModel> jadwal;
  BlocStatus<KrsModel> krs;

  JadwalSemester({this.jadwal, this.krs});
}

class KrsAll {
  String kodeMatkul;
  String namaMatkul;
  String kodeKelas;
  String semester;
  String sks;

  KrsAll(
      {this.kodeMatkul,
      this.namaMatkul,
      this.kodeKelas,
      this.semester,
      this.sks});
  KrsAll.fromjson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matakuliah'];
    namaMatkul = json['nama_matakuliah'];
    kodeKelas = json['kode_kelas'];
    semester = json['semester'];
    sks = json['sks'];
  }
}

class KrsAllModel {
  List<KrsAll> krs;
  String message;

  KrsAllModel({this.krs, this.message});
  KrsAllModel.fromJson(Map<String, dynamic> json) {
    if (json['krs'] != null) {
      krs = List<KrsAll>();
      json['krs'].forEach((v) {
        krs.add(KrsAll.fromjson(v));
      });
    }
    message = json['message'];
  }
}

class Uas {
  String namaMatkul;
  String hari;
  String tanggal;
  String kodeKelas;
  String ruangan;
  String kursi;
  String sks;
  String jam;

  Uas(
      {this.namaMatkul,
      this.hari,
      this.tanggal,
      this.kodeKelas,
      this.ruangan,
      this.kursi,
      this.sks,
      this.jam});

  Uas.fromJson(Map<String, dynamic> json) {
    namaMatkul = json['nama_matakuliah'];
    kodeKelas = json['kode_kelas'];
    sks = json['sks'];
    hari = json['hari'];
    tanggal = json['tanggal_ujian'];
    jam = json['jam'];
    ruangan = json['ruangan'];
    kursi = json['kursi'];
  }
}

class UasModel {
  List<Uas> uas;
  String message;

  UasModel({this.uas, this.message});
  UasModel.fromJson(Map<String, dynamic> json) {
    if (json['uas'] != null) {
      uas = List<Uas>();
      json['uas'].forEach((v) {
        uas.add(Uas.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class KrsSp {
  String kodeMatkul;
  String namaMatkul;
  String kodeKelas;
  String sks;
  String semester;

  KrsSp({this.kodeMatkul, this.namaMatkul, this.sks, this.semester});
  KrsSp.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matakuliah'];
    namaMatkul = json['nama_matakuliah'];
    kodeKelas = json['kode_kelas'];
    sks = json['sks'];
    semester = json['semester1'];
  }
}

class KrsSpModel {
  List<KrsSp> krsSp;
  String message;

  KrsSpModel({this.krsSp, this.message});
  KrsSpModel.fromJson(Map<String, dynamic> json) {
    if (json['krs'] != null) {
      krsSp = List<KrsSp>();
      json['krs'].forEach((v) {
        krsSp.add(KrsSp.fromJson(v));
      });
    }
  }
}

class Absensi {
  String kodeMatkul;
  String namaMatkul;
  String absen1;
  String absen2;
  String absen3;
  String absen4;
  String absen5;
  String absen6;
  String absen7;
  String absen8;
  String absen9;
  String absen10;
  String absen11;
  String absen12;
  String absen13;
  String absen14;
  String absen15;

  Absensi(
      {this.kodeMatkul,
      this.namaMatkul,
      this.absen1,
      this.absen2,
      this.absen3,
      this.absen4,
      this.absen5,
      this.absen6,
      this.absen7,
      this.absen8,
      this.absen9,
      this.absen10,
      this.absen11,
      this.absen12,
      this.absen13,
      this.absen14,
      this.absen15});

  Absensi.fromJson(Map<String, dynamic> json) {
    kodeMatkul = json['kode_matakuliah'];
    namaMatkul = json['nama_matakuliah'];
    absen1 = json['absen1'];
    absen2 = json['absen2'];
    absen3 = json['absen3'];
    absen4 = json['absen4'];
    absen5 = json['absen5'];
    absen6 = json['absen6'];
    absen7 = json['absen7'];
    absen8 = json['absen8'];
    absen9 = json['absen9'];
    absen10 = json['absen10'];
    absen11 = json['absen11'];
    absen12 = json['absen12'];
    absen13 = json['absen13'];
    absen14 = json['absen14'];
    absen15 = json['absen15'];
  }
}

class AbsensiModel {
  List<Absensi> absensi;
  String message;

  AbsensiModel({this.absensi, this.message});

  AbsensiModel.fromJson(Map<String, dynamic> json) {
    if (json['absensi'] != null) {
      absensi = List<Absensi>();
      json['absensi'].forEach((v) {
        absensi.add(Absensi.fromJson(v));
      });
    }
    message = json['message'];
  }
}
