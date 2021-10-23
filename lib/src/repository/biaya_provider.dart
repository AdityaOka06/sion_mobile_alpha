import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../model/biaya_model.dart';
import '../util/shared_config.dart';

class BiayaProvider {
  Future<BiayaModel> fetchBiaya() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, biayaPath);
    var _biayaJson;

    try {
      var _biayaResposne = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _biayaJson = apiResponse(_biayaResposne);
    } catch (e) {
      _biayaJson = errorResponse(e.toString());
    }
    return BiayaModel.fromJson(_biayaJson);
  }
}
