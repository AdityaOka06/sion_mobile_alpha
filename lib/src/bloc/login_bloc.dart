import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../model/login_model.dart';
import '../util/shared_config.dart';
import '../repository/repository.dart';

class LoginBloc {
  Repository _repository = Repository();
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _loginValue = PublishSubject<BlocStatus<LoginModel>>();

  Function(String) get usernameSink => _username.sink.add;
  Function(String) get passwordSink => _password.sink.add;
  Stream<BlocStatus<LoginModel>> get loginStream => _loginValue.stream;

  void dispose() {
    _username.close();
    _password.close();
    _loginValue.close();
  }

  fetchToken() async {
    _loginValue.sink.add(BlocStatus.loading());
    try {
      LoginModel _loginResponse =
          await _repository.loginRepository(_username.value, _password.value);
      if (_loginResponse.token != null) {
        SharedConfig().set(
            "token", "${_loginResponse.tokenType} ${_loginResponse.token}");
      }
      _loginValue.sink.add(BlocStatus.complated(_loginResponse));
    } catch (e) {
      print("bloc error = $e");
      _loginValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
