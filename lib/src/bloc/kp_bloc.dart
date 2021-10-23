import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import '../model/kp_model.dart';
import '../repository/repository.dart';

class KpBloc {
  Repository _repository = Repository();
  final _kpValue = PublishSubject<BlocStatus<KpModel>>();

  Stream<BlocStatus<KpModel>> get kpStream => _kpValue.stream;

  void dispose() {
    _kpValue.close();
  }

  getKp() async {
    _kpValue.sink.add(BlocStatus.loading());
    try {
      var _kpResponse = await _repository.kpRepository();
      print("kp Response = $_kpResponse");
      _kpValue.sink.add(BlocStatus.complated(_kpResponse));
    } catch (e) {
      _kpValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
