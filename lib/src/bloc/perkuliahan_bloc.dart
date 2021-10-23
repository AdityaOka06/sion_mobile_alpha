import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../repository/repository.dart';
import '../model/perkuliahan_model.dart';

class PerkuliahanBloc {
  Repository _repository = Repository();

  final _jadwalValue = PublishSubject<BlocStatus<JadualModel>>();
  final _krsValue = PublishSubject<BlocStatus<KrsModel>>();
  final _krsAllValue = PublishSubject<BlocStatus<KrsAllModel>>();
  final _krsSpValue = PublishSubject<BlocStatus<KrsSpModel>>();
  final _uasValue = PublishSubject<BlocStatus<UasModel>>();
  final _absensiValue = PublishSubject<BlocStatus<AbsensiModel>>();

  Stream<BlocStatus<KrsAllModel>> get krsAllStream => _krsAllValue.stream;
  Stream<BlocStatus<KrsSpModel>> get krsSpstream => _krsSpValue.stream;
  Stream<BlocStatus<UasModel>> get uasStream => _uasValue.stream;
  Stream<BlocStatus<AbsensiModel>> get absensiStream => _absensiValue.stream;
  Stream<JadwalSemester> get jadwalSemesterStream =>
      Rx.combineLatest2(_jadwalValue.stream, _krsValue.stream, (a, b) {
        return JadwalSemester(jadwal: a, krs: b);
      });

  void dispose() {
    _jadwalValue.close();
    _krsValue.close();
    _krsSpValue.close();
    _krsAllValue.close();
    _uasValue.close();
    _absensiValue.close();
  }

  fetchJadwal() async {
    _jadwalValue.sink.add(BlocStatus.loading());
    try {
      var _jadwalResponse = await _repository.jadwalRepository();
      _jadwalValue.sink.add(BlocStatus.complated(_jadwalResponse));
    } catch (e) {
      _jadwalValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchKrs() async {
    _krsValue.sink.add(BlocStatus.loading());
    try {
      var _krsResponse = await _repository.krsRepository();
      _krsValue.sink.add(BlocStatus.complated(_krsResponse));
    } catch (e) {
      _krsValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchKrsAll() async {
    _krsAllValue.sink.add(BlocStatus.loading());
    try {
      var _krsAllResponse = await _repository.krsAllRepository();
      _krsAllValue.sink.add(BlocStatus.complated(_krsAllResponse));
    } catch (e) {
      _krsAllValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchKrsSp() async {
    _krsSpValue.sink.add(BlocStatus.loading());
    try {
      var _krsSpResponse = await _repository.krsSpRepository();
      _krsSpValue.sink.add(BlocStatus.complated(_krsSpResponse));
    } catch (e) {
      _krsSpValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchUas() async {
    _uasValue.sink.add(BlocStatus.loading());
    try {
      var _uasResponse = await _repository.uasRepository();
      _uasValue.sink.add(BlocStatus.complated(_uasResponse));
    } catch (e) {
      _uasValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchAbsensi() async {
    _absensiValue.sink.add(BlocStatus.loading());
    try {
      var _absensiResponse = await _repository.absensiRepository();
      _absensiValue.sink.add(BlocStatus.complated(_absensiResponse));
    } catch (e) {
      _absensiValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
