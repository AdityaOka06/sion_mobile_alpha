import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../repository/repository.dart';
import '../model/pengumuman_model.dart';

class PengumumanBloc {
  final _repository = Repository();
  final _pengumumanValue = PublishSubject<BlocStatus<PengumumanModel>>();

  Stream<BlocStatus<PengumumanModel>> get pengumumanStream =>
      _pengumumanValue.stream;

  void dispose() {
    _pengumumanValue.close();
  }

  fetchPengumuman() async {
    _pengumumanValue.sink.add(BlocStatus.loading());
    try {
      var _pengumumanResponse = await _repository.pengumumanRepository();
      _pengumumanValue.sink.add(BlocStatus.complated(_pengumumanResponse));
    } catch (e) {
      _pengumumanValue.sink.add(BlocStatus.error("$e"));
    }
  }
}
