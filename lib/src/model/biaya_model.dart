class Biaya {
  String semester;
  String tahunAjaran;
  String total;
  String potongan;
  String bayar;
  String denda;

  Biaya(
      {this.semester,
      this.tahunAjaran,
      this.total,
      this.potongan,
      this.bayar,
      this.denda});
  Biaya.fromJson(Map<String, dynamic> json) {
    semester = json['kode_semester'];
    tahunAjaran = json['tahun_ajaran'];
    total = json['total'];
    potongan = json['potongan'];
    bayar = json['bayar'];
    denda = json['denda'];
  }
}

class BiayaModel {
  List<Biaya> biaya;
  String message;

  BiayaModel({this.biaya, this.message});
  BiayaModel.fromJson(Map<String, dynamic> json) {
    if (json['biaya'] != null) {
      biaya = List<Biaya>();
      json['biaya'].forEach((v) {
        biaya.add(Biaya.fromJson(v));
      });
    }
    message = json['message'];
  }
}
