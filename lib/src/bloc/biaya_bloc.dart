import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../model/biaya_model.dart';
import '../repository/repository.dart';

class BiayaBloc {
  Repository _repository = Repository();
  final _biayaValue = PublishSubject<BlocStatus<BiayaModel>>();

  Stream<BlocStatus<BiayaModel>> get biayaStream => _biayaValue.stream;

  dispose() {
    _biayaValue.close();
  }

  fetchBiaya() async {
    _biayaValue.sink.add(BlocStatus.loading());
    try {
      var _biayaResponse = await _repository.biayaRepository();
      _biayaValue.sink.add(BlocStatus.complated(_biayaResponse));
    } catch (e) {
      _biayaValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
