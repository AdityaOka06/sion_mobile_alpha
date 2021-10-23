import '../bloc/bloc_status.dart';

List<String> listhari = [
  null,
  "Minggu",
  "Senin",
  "Selasa",
  "Rabu",
  "Kamis",
  "Jumat",
  "Sabtu"
];

List<String> listbulan = [
  null,
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "Desember"
];

class Pengajuan {
  String nim;
  String judul;
  String judulVerifikasi;
  String keterangan;
  String status;

  Pengajuan(
      {this.nim,
      this.judul,
      this.judulVerifikasi,
      this.keterangan,
      this.status});

  Pengajuan.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    judul = json['judul'];
    judulVerifikasi = json['judul_verifikasi'];
    keterangan = json['keterangan'];
    status = json['status'];
  }
}

class PengajuanModel {
  Pengajuan pengajuan;
  String message;

  PengajuanModel({this.pengajuan, this.message});
  PengajuanModel.fromJson(Map<String, dynamic> json) {
    pengajuan = json['pengajuan'] != null
        ? Pengajuan.fromJson(json['pengajuan'])
        : null;
    message = json['message'];
  }
}

class Topik {
  String kategori;
  String topik;
  String dosen;

  Topik({this.kategori, this.topik, this.dosen});
  Topik.fromJson(Map<String, dynamic> json) {
    kategori = json['kategori'];
    topik = json['topik'];
    dosen = json['dosen'];
  }
}

class TopikModel {
  List<Topik> topik;
  String message;

  TopikModel({this.topik, this.message});

  TopikModel.fromJson(Map<String, dynamic> json) {
    if (json['topik'] != null) {
      topik = List<Topik>();
      json['topik'].forEach((v) {
        topik.add(Topik.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PencarianJudul {
  String nim;
  String nama;
  String judul;
  String namaProdi;

  PencarianJudul({this.nim, this.nama, this.judul, this.namaProdi});
  PencarianJudul.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    nama = json['nama'];
    judul = json['judul'];
    namaProdi = json['nama_prodi'];
  }
}

class PencarianJudulModel {
  List<PencarianJudul> pencarian;
  String message;

  PencarianJudulModel({this.pencarian, this.message});
  PencarianJudulModel.fromJson(Map<String, dynamic> json) {
    if (json['judul'] != null) {
      pencarian = List<PencarianJudul>();
      json['judul'].forEach((v) {
        pencarian.add(PencarianJudul.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class SeminarTerbuka {
  String nim;
  String nama;
  String ruangan;
  String jam;
  int inthari;
  String hari;
  String tanggal;
  int intbulan;
  String bulan;
  String tahun;

  SeminarTerbuka(
      {this.nim,
      this.nama,
      this.ruangan,
      this.jam,
      this.hari,
      this.tanggal,
      this.bulan,
      this.tahun});

  SeminarTerbuka.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    nama = json['nama'];
    jam = json['jam'];
    ruangan = json['ruangan'];
    inthari = int.parse(json['hari']);
    hari = listhari[inthari].toString();
    tanggal = json['tanggal'];
    intbulan = int.parse(json['bulan']);
    bulan = listbulan[intbulan].toString();
    tahun = json['tahun'];
  }
}

class SeminarTerbukaModel {
  List<SeminarTerbuka> seminarTerbuka;
  String message;

  SeminarTerbukaModel({this.seminarTerbuka, this.message});

  SeminarTerbukaModel.fromJson(Map<String, dynamic> json) {
    if (json['jadwal'] != null) {
      seminarTerbuka = List<SeminarTerbuka>();
      json['jadwal'].forEach((v) {
        seminarTerbuka.add(SeminarTerbuka.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Proposal {
  String nim;
  String ruangan;
  String jam;
  int inthari;
  String hari;
  String tanggal;
  int intbulan;
  String bulan;
  String tahun;

  Proposal(
      {this.nim,
      this.ruangan,
      this.jam,
      this.hari,
      this.tanggal,
      this.bulan,
      this.tahun});

  Proposal.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    ruangan = json['ruangan'];
    jam = json['jam'];
    inthari = int.parse(json['hari']);
    hari = listhari[inthari].toString();
    tanggal = json['tanggal'];
    intbulan = int.parse(json['bulan']);
    bulan = listbulan[intbulan].toString();
    tahun = json['tahun'];
  }
}

class ProposalModel {
  List<Proposal> proposal;
  String message;

  ProposalModel({this.proposal, this.message});
  ProposalModel.fromJson(Map<String, dynamic> json) {
    if (json['jadwal'] != null) {
      proposal = List<Proposal>();
      json['jadwal'].forEach((v) {
        proposal.add(Proposal.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Terbuka {
  String ruangan;
  String jam;
  int inthari;
  String hari;
  String tanggal;
  int intBulan;
  String bulan;
  String tahun;

  Terbuka(
      {this.ruangan,
      this.jam,
      this.hari,
      this.tanggal,
      this.bulan,
      this.tahun});

  Terbuka.fromJson(Map<String, dynamic> json) {
    ruangan = json['ruangan'];
    jam = json['jam'];
    inthari = int.parse(json['hari']);
    hari = listhari[inthari].toString();
    tanggal = json['tanggal'];
    intBulan = int.parse(json['bulan']);
    bulan = listbulan[intBulan].toString();
    tahun = json['tahun'];
  }
}

class TerbukaModel {
  List<Terbuka> terbuka;
  String message;

  TerbukaModel({this.terbuka, this.message});
  TerbukaModel.fromJson(Map<String, dynamic> json) {
    if (json['jadwal'] != null) {
      terbuka = List<Terbuka>();
      json['jadwal'].forEach((v) {
        terbuka.add(Terbuka.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Tertutup {
  String nim;
  String nama;
  String ruangan;
  String jam;
  String hari;
  String tanggal;
  int intbulan;
  String bulan;
  String tahun;

  Tertutup(
      {this.nim,
      this.nama,
      this.ruangan,
      this.jam,
      this.hari,
      this.tanggal,
      this.bulan,
      this.tahun});

  Tertutup.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    nama = json['nama'];
    ruangan = json['nama_ruang'];
    jam = json['jam_seminar'];
    hari = json['hari'];
    tanggal = json['tanggal'];
    intbulan = int.parse(json['bulan']);
    bulan = listbulan[intbulan].toString();
    tahun = json['tahun'];
  }
}

class TertutupModel {
  List<Tertutup> tertutup;
  String message;

  TertutupModel({this.tertutup, this.message});
  TertutupModel.fromJson(Map<String, dynamic> json) {
    // if (json['jadwal'] != null) {
    //   tertutup = List<Tertutup>();
    //   json['jadwal'].forEach((v) {
    //     tertutup.add(Tertutup.fromJson(v));
    //   });
    // }
    if (json['jadwal'] != null) {
      tertutup = new List<Tertutup>();
      json['jadwal'].forEach((v) {
        tertutup.add(new Tertutup.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class JadwalModel {
  BlocStatus<ProposalModel> jadwalProposal;
  BlocStatus<TerbukaModel> jadwalTerbuka;
  BlocStatus<TertutupModel> jadwalTertutup;

  JadwalModel({this.jadwalProposal, this.jadwalTerbuka, this.jadwalTertutup});
}
