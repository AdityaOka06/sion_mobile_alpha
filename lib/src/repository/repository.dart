import 'kp_provider.dart';
import 'ta_provider.dart';
import 'login_provider.dart';
import 'nilai_provider.dart';
import 'biaya_provider.dart';
import 'biodata_provider.dart';
import 'akademik_provider.dart';
import 'pencarian_provider.dart';
import 'pengumuman_provider.dart';
import 'perkuliahan_provider.dart';

import '../model/kp_model.dart';
import '../model/ta_model.dart';
import '../model/login_model.dart';
import '../model/nilai_model.dart';
import '../model/biaya_model.dart';
import '../model/biodata_model.dart';
import '../model/akademik_model.dart';
import '../model/pencarian_model.dart';
import '../model/pengumuman_model.dart';
import '../model/perkuliahan_model.dart';

class Repository {
  KpProvider _kpProvider = KpProvider();
  TaProvider _taProvider = TaProvider();
  LoginProvider _loginProvider = LoginProvider();
  BiayaProvider _biayaProvider = BiayaProvider();
  NilaiProvider _nilaiProvider = NilaiProvider();
  BiodataProvider _biodataProvider = BiodataProvider();
  AkademikProvider _akademikProvider = AkademikProvider();
  PencarianProvider _pencarianProvier = PencarianProvider();
  PengumumanProvider _pengumumanProvider = PengumumanProvider();
  PerkuliahanProvider _perkuliahanProvider = PerkuliahanProvider();

  Future<LoginModel> loginRepository(String username, password) =>
      _loginProvider.fetchToken(username, password);

  Future<PengumumanModel> pengumumanRepository() =>
      _pengumumanProvider.fetchPengumuman();

  Future<BiodataModel> biodataRepository() => _biodataProvider.fetchBiodata();
  Future<BiodataModel> checkBiodataRepository() =>
      _biodataProvider.getBiodata();

  Future<MahasiswaModel> mahasiswaRepository(q) =>
      _pencarianProvier.fetchMahasiswa(q);
  Future<DosenModel> dosenRepository(q) => _pencarianProvier.fetchDosen(q);

  Future<KpModel> kpRepository() => _kpProvider.fetchKp();

  Future<IpModel> ipRepository() => _nilaiProvider.fetchIp();
  Future<TranskripModel> transktipRepository() =>
      _nilaiProvider.fetchTranskrip();
  Future<HistoriModel> historiRepository(semester) =>
      _nilaiProvider.fetchHistori(semester);

  Future<BiayaModel> biayaRepository() => _biayaProvider.fetchBiaya();

  Future<PengajuanModel> pengajuanRepository() => _taProvider.fetchPengajuan();
  Future<TopikModel> topikRepository() => _taProvider.fetchTopik();
  Future<PencarianJudulModel> pencarianJudulRepository(String q) =>
      _taProvider.fetchPencarianJudul(q);
  Future<SeminarTerbukaModel> seminarTerbukaRepository() =>
      _taProvider.fetchSeminarTerbuka();
  Future<ProposalModel> proposalRepository() =>
      _taProvider.fetchSidangProposal();
  Future<TerbukaModel> terbukaRepository() => _taProvider.fetchSidangTerbuka();
  Future<TertutupModel> tertutupRepository() =>
      _taProvider.fetchSidangTertutup();

  Future<JadualModel> jadwalRepository() => _perkuliahanProvider.fetchJadwal();
  Future<KrsModel> krsRepository() => _perkuliahanProvider.fetchKrs();
  Future<KrsAllModel> krsAllRepository() => _perkuliahanProvider.fetchKrsAll();
  Future<KrsSpModel> krsSpRepository() => _perkuliahanProvider.fetchKrsSp();
  Future<UasModel> uasRepository() => _perkuliahanProvider.fetchUas();
  Future<AbsensiModel> absensiRepository() =>
      _perkuliahanProvider.fetchAbsensi();

  Future<PrasyaratModel> prasyaratRepository() =>
      _akademikProvider.fetchPrasyarat();
  Future<PerwalianModel> perwalianRepository() =>
      _akademikProvider.fetchPerwalian();
  Future<PollingModel> pollingRepository() => _akademikProvider.fetchPolling();
  Future<SisaMatkulModel> sisaMatkulRepository() =>
      _akademikProvider.fetchSisaMatkul();
}
