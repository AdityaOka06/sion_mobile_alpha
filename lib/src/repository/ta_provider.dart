import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/ta_model.dart';
import '../util/api_config.dart';
import 'response_repository.dart';
import '../util/shared_config.dart';

class TaProvider {
  Future<PengajuanModel> fetchPengajuan() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, pengajuanPath);
    var _pengajuanJson;

    try {
      var _pengajuanResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      print("status code = ${_pengajuanResponse.statusCode}");
      _pengajuanJson = apiResponse(_pengajuanResponse);
    } catch (e) {
      _pengajuanJson = errorResponse(e.toString());
    }

    return PengajuanModel.fromJson(_pengajuanJson);
  }

  Future<TopikModel> fetchTopik() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, topikPath);
    var _topikJson;

    try {
      var _topikResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _topikJson = apiResponse(_topikResponse);
    } catch (e) {
      _topikJson = errorResponse(e.toString());
    }

    return TopikModel.fromJson(_topikJson);
  }

  Future<PencarianJudulModel> fetchPencarianJudul(String q) async {
    var _token = await SharedConfig().get("token");
    Map<String, String> _data = {"q": q};
    Uri _uri = Uri.https(baseApi, pencarianJudulPath, _data);
    var _pencarianJudulJson;

    try {
      var _pencarianJudulResponse = await http.post(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _pencarianJudulJson = apiResponse(_pencarianJudulResponse);
    } catch (e) {
      _pencarianJudulJson = errorResponse(e.toString());
    }

    return PencarianJudulModel.fromJson(_pencarianJudulJson);
  }

  Future<SeminarTerbukaModel> fetchSeminarTerbuka() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, seminarTerbukaPath);
    var _seminarTerbukajson;

    try {
      var _seminarTerbukaResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _seminarTerbukajson = apiResponse(_seminarTerbukaResponse);
    } catch (e) {
      _seminarTerbukajson = errorResponse(e.toString());
    }

    return SeminarTerbukaModel.fromJson(_seminarTerbukajson);
  }

  Future<ProposalModel> fetchSidangProposal() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, jadwalProposalPath);
    var _proposalJson;

    try {
      var _proposalResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _proposalJson = apiResponse(_proposalResponse);
    } catch (e) {
      _proposalJson = errorResponse(e.toString());
    }
    return ProposalModel.fromJson(_proposalJson);
  }

  Future<TerbukaModel> fetchSidangTerbuka() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.https(baseApi, jadwalTerbukaPath);
    var _terbukaJson;

    try {
      var _terbukaResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _terbukaJson = apiResponse(_terbukaResponse);
    } catch (e) {
      _terbukaJson = errorResponse(e.toString());
    }

    return TerbukaModel.fromJson(_terbukaJson);
  }

  Future<TertutupModel> fetchSidangTertutup() async {
    var _token = await SharedConfig().get("token");
    Uri _uri = Uri.http(baseApi, jadwalSidangPath);
    var _tertutupJson;

    try {
      var _tertutupResponse = await http.get(_uri, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "$_token"
      });
      _tertutupJson = apiResponse(_tertutupResponse);
    } catch (e) {
      _tertutupJson = errorResponse(e.toString());
    }

    return TertutupModel.fromJson(_tertutupJson);
  }
}
