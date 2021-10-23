class LoginModel {
  String token;
  String tokenType;
  String message;

  LoginModel({this.token, this.tokenType, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
  }

  LoginModel.withError(String message) {
    message = message;
  }
}
