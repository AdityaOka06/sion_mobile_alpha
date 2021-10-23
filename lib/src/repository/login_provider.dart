import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../util/api_config.dart';
import 'response_repository.dart';
import '../model/login_model.dart';

class LoginProvider {
  Future<LoginModel> fetchToken(String username, password) async {
    Map<String, String> _data = {"username": username, "password": password};
    Uri _uri = Uri.https(baseApi, loginPath, _data);
    var _loginJson;

    try {
      var _loginresponse = await http.post(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
      });
      _loginJson = apiResponse(_loginresponse);
    } on SocketException catch (e) {
      print("error = $e");
      _loginJson = errorResponse(e.toString());
    }
    return LoginModel.fromJson(_loginJson);
  }
}
