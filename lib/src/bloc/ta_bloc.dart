import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../model/ta_model.dart';
import '../repository/repository.dart';

class TaBloc {
  Repository _repository = Repository();

  List<BlocStatus<JadwalModel>> jadwalList = [];

  final _topikValue = PublishSubject<BlocStatus<TopikModel>>();
  final _pengajuanValue = PublishSubject<BlocStatus<PengajuanModel>>();
  final _pencarianJudulValue =
      PublishSubject<BlocStatus<PencarianJudulModel>>();
  final _seminarTerbukaValue =
      PublishSubject<BlocStatus<SeminarTerbukaModel>>();
  final _jadwalProposalValue = PublishSubject<BlocStatus<ProposalModel>>();
  final _jadwalTerbukaValue = PublishSubject<BlocStatus<TerbukaModel>>();
  final _jadwalTertutupValue = PublishSubject<BlocStatus<TertutupModel>>();

  final _pencarianJudulParam = BehaviorSubject<String>();

  Stream<BlocStatus<PengajuanModel>> get pengajuanStream =>
      _pengajuanValue.stream;
  Stream<BlocStatus<TopikModel>> get topikStream => _topikValue.stream;
  Stream<BlocStatus<PencarianJudulModel>> get pencarianJudulStream =>
      _pencarianJudulValue.stream;
  Stream<BlocStatus<SeminarTerbukaModel>> get seminarTerbukaStream =>
      _seminarTerbukaValue.stream;
  Stream<BlocStatus<ProposalModel>> get proposalStream =>
      _jadwalProposalValue.stream;
  Stream<BlocStatus<TerbukaModel>> get terbukaStream =>
      _jadwalTerbukaValue.stream;
  Stream<BlocStatus<TertutupModel>> get tertutupStream =>
      _jadwalTertutupValue.stream;

  Stream<JadwalModel> get jadwalStream => Rx.combineLatest3(
          _jadwalProposalValue.stream,
          _jadwalTerbukaValue.stream,
          _jadwalTertutupValue.stream, (a, b, c) {
        return JadwalModel(
            jadwalProposal: a, jadwalTerbuka: b, jadwalTertutup: c);
      });

  Function(String) get pencarianJudulSink => _pencarianJudulParam.sink.add;

  void dispose() {
    _topikValue.close();
    _pengajuanValue.close();
    _pencarianJudulValue.close();
    _seminarTerbukaValue.close();
    _jadwalProposalValue.close();
    _jadwalTerbukaValue.close();
    _jadwalTertutupValue.close();

    _pencarianJudulParam.close();
  }

  fetchPengajuan() async {
    _pengajuanValue.sink.add(BlocStatus.loading());
    try {
      var _pengajuanResponse = await _repository.pengajuanRepository();
      _pengajuanValue.sink.add(BlocStatus.complated(_pengajuanResponse));
    } catch (e) {
      _pengajuanValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchTopik() async {
    _topikValue.sink.add(BlocStatus.loading());
    try {
      var _topikResponse = await _repository.topikRepository();
      _topikValue.sink.add(BlocStatus.complated(_topikResponse));
    } catch (e) {
      _topikValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchPencarianJudul() async {
    _pencarianJudulValue.sink.add(BlocStatus.loading());
    try {
      var _pencarianJudulResponse = await _repository
          .pencarianJudulRepository(_pencarianJudulParam.value);
      _pencarianJudulValue.sink
          .add(BlocStatus.complated(_pencarianJudulResponse));
    } catch (e) {
      _pencarianJudulValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchSeminarTerbuka() async {
    _seminarTerbukaValue.sink.add(BlocStatus.loading());
    try {
      var _seminarResponse = await _repository.seminarTerbukaRepository();
      _seminarTerbukaValue.sink.add(BlocStatus.complated(_seminarResponse));
    } catch (e) {
      _seminarTerbukaValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchJadwalProposal() async {
    _jadwalProposalValue.sink.add(BlocStatus.loading());
    try {
      var _jadwalProposalResponse = await _repository.proposalRepository();
      _jadwalProposalValue.sink
          .add(BlocStatus.complated(_jadwalProposalResponse));
    } catch (e) {
      _jadwalProposalValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchJadwalTerbuka() async {
    _jadwalTerbukaValue.sink.add(BlocStatus.loading());
    try {
      var _jadwalTerbukaResponse = await _repository.terbukaRepository();
      _jadwalTerbukaValue.sink
          .add(BlocStatus.complated(_jadwalTerbukaResponse));
    } catch (e) {
      _jadwalTerbukaValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  fetchJadwalTertutup() async {
    _jadwalTertutupValue.sink.add(BlocStatus.loading());
    try {
      var _jadwalTertutupResponse = await _repository.tertutupRepository();
      _jadwalTertutupValue.sink
          .add(BlocStatus.complated(_jadwalTertutupResponse));
    } catch (e) {
      _jadwalTertutupValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
