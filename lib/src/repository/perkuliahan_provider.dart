import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';
import '../model/perkuliahan_model.dart';

class PerkuliahanProvider {
  Future<JadualModel> fetchJadwal() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, jadwalKuliahPath);
    var _jadwalJson;

    try {
      var _jadwalResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _jadwalJson = apiResponse(_jadwalResponse);
    } catch (e) {
      _jadwalJson = errorResponse(e.toString());
    }

    return JadualModel.fromJson(_jadwalJson);
  }

  Future<KrsModel> fetchKrs() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, krsSemesterPath);
    var _krsJson;

    try {
      var _krsResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _krsJson = apiResponse(_krsResponse);
    } catch (e) {
      _krsJson = errorResponse(e.toString());
    }
    return KrsModel.fromJson(_krsJson);
  }

  Future<KrsAllModel> fetchKrsAll() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, krsAllPath);
    var _krsAllJson;

    try {
      var _krsAllResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _krsAllJson = apiResponse(_krsAllResponse);
    } catch (e) {
      _krsAllJson = errorResponse(e.toString());
    }

    return KrsAllModel.fromJson(_krsAllJson);
  }

  Future<KrsSpModel> fetchKrsSp() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, krsSpPath);
    var _krsSpJson;

    try {
      var _krsSpResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _krsSpJson = apiResponse(_krsSpResponse);
    } catch (e) {
      _krsSpJson = errorResponse(e.toString());
    }
    return KrsSpModel.fromJson(_krsSpJson);
  }

  Future<UasModel> fetchUas() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, uasPath);
    var _uasJson;

    try {
      var _uasResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _uasJson = apiResponse(_uasResponse);
    } catch (e) {
      _uasJson = errorResponse(e.toString());
    }
    return UasModel.fromJson(_uasJson);
  }

  Future<AbsensiModel> fetchAbsensi() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, absensiPath);
    var _absensiJson;

    try {
      var _absensiResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _absensiJson = apiResponse(_absensiResponse);
    } catch (e) {
      _absensiJson = errorResponse(e.toString());
    }

    return AbsensiModel.fromJson(_absensiJson);
  }
}
