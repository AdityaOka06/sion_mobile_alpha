import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../model/akademik_model.dart';
import '../repository/repository.dart';

class AkademikBloc {
  Repository _repository = Repository();

  final _prasyaratValue = PublishSubject<BlocStatus<PrasyaratModel>>();
  final _perwalianValue = PublishSubject<BlocStatus<PerwalianModel>>();
  final _pollingValue = PublishSubject<BlocStatus<PollingModel>>();
  final _sisaMatkulValue = PublishSubject<BlocStatus<SisaMatkulModel>>();

  Stream<BlocStatus<PrasyaratModel>> get prasyaratStream =>
      _prasyaratValue.stream;
  Stream<BlocStatus<PerwalianModel>> get perwalianStream =>
      _perwalianValue.stream;
  Stream<BlocStatus<PollingModel>> get pollingStream => _pollingValue.stream;
  Stream<BlocStatus<SisaMatkulModel>> get sisaMatkulStream =>
      _sisaMatkulValue.stream;

  void dispose() {
    _prasyaratValue.close();
    _perwalianValue.close();
    _pollingValue.close();
    _sisaMatkulValue.close();
  }

  fetchPrasyarat() async {
    _prasyaratValue.sink.add(BlocStatus.loading());
    try {
      var _prasyaratResponse = await _repository.prasyaratRepository();
      _prasyaratValue.sink.add(BlocStatus.complated(_prasyaratResponse));
    } catch (e) {
      _prasyaratValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchPerwalian() async {
    _perwalianValue.sink.add(BlocStatus.loading());
    try {
      var _perwalianResponse = await _repository.perwalianRepository();
      _perwalianValue.sink.add(BlocStatus.complated(_perwalianResponse));
    } catch (e) {
      _prasyaratValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchPolling() async {
    _pollingValue.sink.add(BlocStatus.loading());
    try {
      var _pollingResponse = await _repository.pollingRepository();
      _pollingValue.sink.add(BlocStatus.complated(_pollingResponse));
    } catch (e) {
      _pollingValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchSisaMatakuliah() async {
    _sisaMatkulValue.sink.add(BlocStatus.loading());
    try {
      var _sisaMatkulResponse = await _repository.sisaMatkulRepository();
      _sisaMatkulValue.sink.add(BlocStatus.complated(_sisaMatkulResponse));
    } catch (e) {
      _sisaMatkulValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
