import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';
import '../model/biodata_model.dart';

class BiodataProvider {
  Future<BiodataModel> fetchBiodata() async {
    Uri _uri = Uri.http(baseApi, biodataPath);
    var _token = await SharedConfig().get("token");
    var _biodataJson;

    try {
      var _biodataResposne = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      if (_biodataResposne.statusCode == 200) {
        SharedConfig().set("biodata", _biodataResposne.body);
      }
      _biodataJson = apiResponse(_biodataResposne);
    } catch (e) {
      return _biodataJson = errorResponse(e.toString());
    }
    return BiodataModel.fromJson(_biodataJson);
  }

  Future<BiodataModel> getBiodata() async {
    var _biodata = await SharedConfig().get("biodata");
    if (_biodata == null) {
      return fetchBiodata();
    } else {
      return BiodataModel.fromJson(_biodata);
    }
  }
}
