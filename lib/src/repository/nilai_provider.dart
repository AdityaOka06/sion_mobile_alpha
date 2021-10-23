import 'package:sion_app/src/model/nilai_model.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../model/nilai_model.dart';
import '../util/shared_config.dart';

class NilaiProvider {
  Future<IpModel> fetchIp() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, ipPath);
    var _ipJson;

    try {
      var _ipResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _ipJson = apiResponse(_ipResponse);
    } catch (e) {
      _ipJson = errorResponse(e.toString());
    }

    return IpModel.fromJson(_ipJson);
  }

  Future<TranskripModel> fetchTranskrip() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, transkripPath);
    var _transkripJosn;

    try {
      var _transkripResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _transkripJosn = apiResponse(_transkripResponse);
      print("transkrip Response = ${_transkripResponse.statusCode}");
    } catch (e) {
      _transkripJosn = errorResponse(e.toString());
    }
    return TranskripModel.fromJson(_transkripJosn);
  }

  Future<HistoriModel> fetchHistori(semester) async {
    var _token = await SharedConfig().get("token");
    Map<String, String> _data = {"semester": semester};
    Uri _uri = Uri.https(baseApi, historiPath, _data);
    var _historiJson;

    try {
      print("uri = $_uri");
      var _historiResponse = await http.post(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      print("hasil response = ${_historiResponse.statusCode}");
      _historiJson = apiResponse(_historiResponse);
    } catch (e) {
      print("error = $e");
      _historiJson = errorResponse(e.toString());
    }
    return HistoriModel.fromJson(_historiJson);
  }
}
