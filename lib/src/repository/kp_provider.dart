import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/kp_model.dart';
import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';

class KpProvider {
  Future<KpModel> fetchKp() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.http(baseApi, kpPath);
    var _kpJson;

    try {
      var _kpResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": _token
      });
      _kpJson = apiResponse(_kpResponse);
    } catch (e) {
      _kpJson = errorResponse(e.toString());
    }

    return KpModel.fromJson(_kpJson);
  }
}
