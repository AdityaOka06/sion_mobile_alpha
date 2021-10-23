import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import '../model/biodata_model.dart';
import '../repository/repository.dart';

class BiodataBloc {
  Repository _repository = Repository();
  final _biodataValue = PublishSubject<BlocStatus<BiodataModel>>();

  Stream<BlocStatus<BiodataModel>> get biodataStream => _biodataValue.stream;

  void dispose() {
    _biodataValue.close();
  }

  fetchBiodata() async {
    _repository.biodataRepository();
  }

  getBiodata() async {
    _biodataValue.sink.add(BlocStatus.loading());
    try {
      var _biodataResponse = await _repository.checkBiodataRepository();
      _biodataValue.sink.add(BlocStatus.complated(_biodataResponse));
    } catch (e) {
      _biodataValue.sink.add(BlocStatus.error(e.toString()));
    }
  }
}
