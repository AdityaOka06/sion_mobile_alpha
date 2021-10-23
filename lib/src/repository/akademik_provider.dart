import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';
import '../model/akademik_model.dart';

class AkademikProvider {
  Future<PrasyaratModel> fetchPrasyarat() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, prasyaratPath);
    var _prasyaratJson;

    try {
      var _prasyaratResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _prasyaratJson = apiResponse(_prasyaratResponse);
    } catch (e) {
      _prasyaratJson = errorResponse(e.toString());
    }
    return PrasyaratModel.fromJson(_prasyaratJson);
  }

  Future<PerwalianModel> fetchPerwalian() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, perwalianPath);
    var _perwalianJson;

    try {
      var _perwalianResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _perwalianJson = apiResponse(_perwalianResponse);
    } catch (e) {
      _perwalianJson = errorResponse(e.toString());
    }

    return PerwalianModel.fromJson(_perwalianJson);
  }

  Future<PollingModel> fetchPolling() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, pollingPath);
    var _pollingJson;

    try {
      var _pollingResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _pollingJson = apiResponse(_pollingResponse);
    } catch (e) {
      _pollingJson = errorResponse(e.toString());
    }
    return PollingModel.fromJson(_pollingJson);
  }

  Future<SisaMatkulModel> fetchSisaMatkul() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, sisaMatakuliahPath);
    var _sisaMatkulJson;

    try {
      var _sisaMatkulResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _sisaMatkulJson = apiResponse(_sisaMatkulResponse);
    } catch (e) {
      _sisaMatkulJson = errorResponse(e.toString());
    }
    return SisaMatkulModel.fromJson(_sisaMatkulJson);
  }
}
