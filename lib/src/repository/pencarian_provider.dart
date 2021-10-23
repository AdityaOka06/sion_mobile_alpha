import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';
import '../model/pencarian_model.dart';

class PencarianProvider {
  Future<MahasiswaModel> fetchMahasiswa(q) async {
    Map<String, String> _data = {"q": q};
    Uri _uri = Uri.https(baseApi, mahasiswaPath, _data);
    var _token = await SharedConfig().get("token");
    var _mahasiswaJson;

    try {
      var _mahasiswaResponse = await http.post(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _mahasiswaJson = apiResponse(_mahasiswaResponse);
    } on SocketException catch (e) {
      print("error = $e");
      _mahasiswaJson = errorResponse(e.toString());
    }
    return MahasiswaModel.fromJson(_mahasiswaJson);
  }

  Future<DosenModel> fetchDosen(q) async {
    Map<String, String> _data = {"q": q};
    Uri _uri = Uri.https(baseApi, dosenPath, _data);
    var _token = await SharedConfig().get("token");
    var _dosenJson;

    try {
      var _dosenResponse = await http.post(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _dosenJson = apiResponse(_dosenResponse);
    } on SocketException catch (e) {
      _dosenJson = errorResponse(e.toString());
    }
    return DosenModel.fromJson(_dosenJson);
  }
}
