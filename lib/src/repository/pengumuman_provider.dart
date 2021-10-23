import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';
import '../model/pengumuman_model.dart';

class PengumumanProvider {
  Future<PengumumanModel> fetchPengumuman() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, pengumumanPath);
    var _pengumumanJson;

    try {
      print("Pengumuman uri = $baseApi$pengumumanPath");
      var _pengumumanResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      print("Pengumuman response = ${_pengumumanResponse.statusCode}}");
      _pengumumanJson = apiResponse(_pengumumanResponse);
    } on SocketException catch (e) {
      print("error = $e");
      _pengumumanJson = errorResponse(e.toString());
    } catch (e) {
      _pengumumanJson = errorResponse(e.toString());
    }

    return PengumumanModel.fromJson(_pengumumanJson);
  }
}
