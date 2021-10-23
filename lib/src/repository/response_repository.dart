import 'dart:convert';
import 'package:http/http.dart' as http;

import '../util/exception_config.dart';

dynamic apiResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var _responseJson = json.decode(response.body.toString());
      return _responseJson;
      break;
    case 400:
      throw BadRequestException();
      break;
    case 401:
    case 403:
      throw UnauthorisedException();
      break;
    case 405:
      throw MethodNotAllowed();
      break;
    case 408:
      throw TimeOutException();
      break;
    case 500:
    default:
      throw FetchDataException();
      break;
  }
}

dynamic errorResponse(String exception) {
  print("error = $exception");
  throw FetchDataException(exception);
}
