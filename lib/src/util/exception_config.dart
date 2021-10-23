class AppException implements Exception {
  final _message;
  final _perfix;

  AppException([this._message, this._perfix]);
  String toString() {
    if (_perfix == null) {
      return "$_message";
    } else {
      return "$_perfix $_message";
    }
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Terjadi kesalahan saat melakukan komunikasi data : ");
}

class BadRequestException extends AppException {
  BadRequestException([String message]) : super("Bad Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String message]) : super("Unauthorised");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super("Invalid Input");
}

class MethodNotAllowed extends AppException {
  MethodNotAllowed([String message]) : super("Method not Allowed");
}

class NoInternetException extends AppException {
  NoInternetException([String message]) : super("No Internet Connection");
}

class TimeOutException extends AppException {
  TimeOutException([String message]) : super("Time Out");
}
