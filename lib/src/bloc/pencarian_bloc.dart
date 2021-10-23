import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_status.dart';
import '../model/pencarian_model.dart';
import '../repository/repository.dart';

class PencarianBloc {
  Repository _repository = Repository();
  final _mahasiswaValue = PublishSubject<BlocStatus<MahasiswaModel>>();
  final _dosenValue = PublishSubject<BlocStatus<DosenModel>>();
  final _mahasiswaQ = BehaviorSubject<String>();
  final _dosenQ = BehaviorSubject<String>();

  Stream<BlocStatus<MahasiswaModel>> get mahasiswaStream =>
      _mahasiswaValue.stream;
  Stream<BlocStatus<DosenModel>> get dosenStream => _dosenValue.stream;
  Function(String) get mahasiswaSink => _mahasiswaQ.sink.add;
  Function(String) get dosenSink => _dosenQ.sink.add;

  void dispose() {
    _mahasiswaValue.close();
    _dosenValue.close();
    _mahasiswaQ.close();
    _dosenQ.close();
  }

  getMahasiswa() async {
    _mahasiswaValue.sink.add(BlocStatus.loading());
    try {
      MahasiswaModel _mahasiswaRespons =
          await _repository.mahasiswaRepository(_mahasiswaQ.value);
      _mahasiswaValue.sink.add(BlocStatus.complated(_mahasiswaRespons));
    } catch (e) {
      print("error = $e");
      _mahasiswaValue.sink.add(BlocStatus.error(e.toString()));
    }
  }

  getDosen() async {
    _dosenValue.sink.add(BlocStatus.loading());
    try {
      DosenModel _dosenResponse =
          await _repository.dosenRepository(_dosenQ.value);
      _dosenValue.sink.add(BlocStatus.complated(_dosenResponse));
    } catch (e) {
      _dosenValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
