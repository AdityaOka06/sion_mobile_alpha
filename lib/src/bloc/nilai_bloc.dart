import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import '../model/nilai_model.dart';
import '../repository/repository.dart';

class NilaiBloc {
  Repository _repository = Repository();

  final _ipValue = PublishSubject<BlocStatus<IpModel>>();
  final _transkripValue = PublishSubject<BlocStatus<TranskripModel>>();
  final _historiValue = PublishSubject<BlocStatus<HistoriModel>>();
  final _historiParam = BehaviorSubject<String>();

  Stream<BlocStatus<IpModel>> get ipStream => _ipValue.stream;
  Stream<BlocStatus<TranskripModel>> get transkripStream =>
      _transkripValue.stream;
  Stream<BlocStatus<HistoriModel>> get historiStream => _historiValue.stream;
  Function(String) get historiSink => _historiParam.sink.add;

  void dispose() {
    _ipValue.close();
    _transkripValue.close();
    _historiValue.close();
    _historiParam.close();
  }

  fetchIp() async {
    _ipValue.sink.add(BlocStatus.loading());
    try {
      var _ipResponse = await _repository.ipRepository();
      _ipValue.sink.add(BlocStatus.complated(_ipResponse));
    } catch (e) {
      _ipValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchTranskrip() async {
    _transkripValue.sink.add(BlocStatus.loading());
    try {
      var _transkripResponse = await _repository.transktipRepository();
      _transkripValue.sink.add(BlocStatus.complated(_transkripResponse));
    } catch (e) {
      _transkripValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchHistori() async {
    _historiValue.sink.add(BlocStatus.loading());
    try {
      print("param = ${_historiParam.value}");
      var _historiResponse =
          await _repository.historiRepository(_historiParam.value);
      _historiValue.sink.add(BlocStatus.complated(_historiResponse));
    } catch (e) {
      _historiValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
