class KpModel {
  String status;
  String statusAnggota;
  String message;

  KpModel({this.status, this.statusAnggota, this.message});
  KpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusAnggota = json['status_anggota'];
    message = json['message'];
  }
}
