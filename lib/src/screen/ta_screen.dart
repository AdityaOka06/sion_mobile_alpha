import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';

import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../screen/login_screen.dart';
import '../widget/drawer_widget.dart';
import '../widget/settings_widget.dart';

TaBloc _taBloc = TaBloc();

class TaScreen extends StatefulWidget {
  TaScreen({Key key}) : super(key: key);

  @override
  _TaScreenState createState() => _TaScreenState();
}

class _TaScreenState extends State<TaScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Tugas Akhir"),
            actions: [SettingsWidget()],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Pengajuan",
                ),
                Tab(
                  text: "Jadwal",
                ),
                Tab(
                  text: "Topik",
                ),
                Tab(
                  text: "Pencarian Judul",
                ),
                Tab(
                  text: "Jadwal Seminar Terbuka",
                )
              ],
            ),
          ),
          drawer: DrawerWidget(),
          body: TabBarView(
            children: [
              PengajuanPage(),
              JadwalPage(),
              TopikPage(),
              PencarianPage(),
              SeminarTerbukaPage(),
            ],
          ),
        ));
  }
}

//Pengajuan Page--------------------------------------------------------------//
class PengajuanPage extends StatefulWidget {
  PengajuanPage({Key key}) : super(key: key);

  @override
  _PengajuanPageState createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage> {
  @override
  void initState() {
    super.initState();
    _taBloc.fetchPengajuan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _taBloc.pengajuanStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == Status.ERROR) {
              if (snapshot.data.message.contains("Unauthorised")) {
                return Container(
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Sesi anda sudah habis \n"
                        "Silahkan melakukan proses Login kembali",
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("Login"))
                    ],
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                  child: Text(
                    "Terjadi kesalahan saat melakukan pengambilan data \n"
                    "Silahkan coba lagi",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              var _pengajuan = snapshot.data.data.pengajuan;
              if (_pengajuan.status.contains("belum mengajukan judul")) {
                return Center(
                  child:
                      Text("${_pengajuan.status}", textAlign: TextAlign.center),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 3,
                          left: SizeConfig.blokHorizontal * 2,
                          right: SizeConfig.blokHorizontal * 2),
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Theme.of(context).buttonColor)),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ListTile(
                            title: Text("Judul"),
                            subtitle: Text("${_pengajuan.judul}"),
                          ),
                          ListTile(
                            title: Text("Status"),
                            subtitle: Text("${_pengajuan.status}"),
                          ),
                          ListTile(
                            title: Text("Keterangan"),
                            subtitle: Text("${_pengajuan.keterangan}"),
                          ),
                          ListTile(
                            title: Text("Judul Verifikasi"),
                            subtitle: Text("${_pengajuan.judulVerifikasi}"),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            } else {
              return SpinKitFadingCircle(
                color: Theme.of(context).buttonColor,
              );
            }
          } else {
            return SpinKitFadingCircle(
              color: Theme.of(context).buttonColor,
            );
          }
        },
      ),
    );
  }
}
//Pengajuan Page--------------------------------------------------------------//

//Jadwal Page-----------------------------------------------------------------//
class JadwalPage extends StatefulWidget {
  JadwalPage({Key key}) : super(key: key);

  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  @override
  void initState() {
    super.initState();
    _taBloc.fetchJadwalProposal();
    _taBloc.fetchJadwalTerbuka();
    _taBloc.fetchJadwalTertutup();
  }

  @override
  Widget build(BuildContext context) {
    //snapshot.data.jadwalTerbuka.data.terbuka.length
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blokVertical * 2),
      child: StreamBuilder(
        stream: _taBloc.jadwalStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blokVertical * 1,
                  left: SizeConfig.blokHorizontal * 2,
                  right: SizeConfig.blokHorizontal * 2),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    child: ExpansionTile(
                      title: Text("Jadwal Proposal"),
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 20,
                            ),
                            child: proposalBody(
                                snapshot.data.jadwalProposal, context))
                      ],
                    ),
                  ),
                  Container(
                    child: ExpansionTile(
                      title: Text("Jadwal Terbuka"),
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          child:
                              terbukaBody(snapshot.data.jadwalTerbuka, context),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ExpansionTile(
                      title: Text("Jadwal Tertutup"),
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          child: tertutupBody(
                              snapshot.data.jadwalTertutup, context),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            return SpinKitFadingCircle(
              color: Theme.of(context).buttonColor,
            );
          }
        },
      ),
    );
  }
}

//Proposal Body---------------------------------------------------------------//
Widget proposalBody(snapshot, context) {
  if (snapshot.status == Status.ERROR) {
    if (snapshot.message.include("Unauthorised")) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sesi anda telah habis\n"
              "silahkan melakukan proses Login kembali"),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text("Login"),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Terjadi kesalahan saat melakukan pengambilan data \n"
            "Silahkan coba lagi nanti",
            textAlign: TextAlign.center,
          ),
          FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("Login"))
        ],
      );
    }
  } else if (snapshot.status == Status.COMPLATED) {
    var _proposal = snapshot.data.proposal;
    if (_proposal.length == 0) {
      return Center(child: Text("Jadwal sidang proposal belum tersedia"));
    } else {
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text("Hari / Tanggal"),
            subtitle: Text("${_proposal[0].hari} / ${_proposal[0].tanggal}"
                " ${_proposal[0].bulan} ${_proposal[0].tahun}"),
          ),
          ListTile(
            title: Text("Jam"),
            subtitle: Text("${_proposal[0].jam}"),
          ),
          ListTile(
            title: Text("Ruangan"),
            subtitle: Text("${_proposal[0].ruangan}"),
          )
        ],
      );
    }
  } else {
    return SpinKitFadingCircle(
      color: Theme.of(context).buttonColor,
      size: 30,
    );
  }
}
//Proposal Body---------------------------------------------------------------//

//Terbuka Body----------------------------------------------------------------//
Widget terbukaBody(snapshot, context) {
  if (snapshot.status == Status.ERROR) {
    if (snapshot.message.include("Unauthorised")) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sesi anda telah habis\n"
              "silahkan melakukan proses Login kembali"),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text("Login"),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Terjadi kesalahan saat melakukan pengambilan data \n"
            "Silahkan coba lagi nanti",
            textAlign: TextAlign.center,
          ),
          FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("Login"))
        ],
      );
    }
  } else if (snapshot.status == Status.COMPLATED) {
    var _terbuka = snapshot.data.terbuka;
    if (_terbuka.length == 0) {
      return Center(child: Text("Jadwal sidang terbuka belum tersedia"));
    } else {
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text("Hari / Tanggal"),
            subtitle: Text("${_terbuka[0].hari} / "
                "${_terbuka[0].tanggal} ${_terbuka[0].bulan} ${_terbuka[0].tahun}"),
          ),
          ListTile(
            title: Text("Jam"),
            subtitle: Text("${_terbuka[0].jam}"),
          ),
          ListTile(
            title: Text("Ruangan"),
            subtitle: Text("${_terbuka[0].ruangan}"),
          )
        ],
      );
    }
  } else {
    return SpinKitFadingCircle(
      color: Theme.of(context).buttonColor,
      size: 30,
    );
  }
}
//Terbuka Body----------------------------------------------------------------//

//Tertutup Body---------------------------------------------------------------//
Widget tertutupBody(snapshot, context) {
  if (snapshot.status == Status.ERROR) {
    if (snapshot.message.include("Unauthorised")) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sesi anda telah habis\n"
              "silahkan melakukan proses Login kembali"),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text("Login"),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Terjadi kesalahan saat melakukan pengambilan data \n"
            "Silahkan coba lagi nanti",
            textAlign: TextAlign.center,
          ),
          FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("Login"))
        ],
      );
    }
  } else if (snapshot.status == Status.COMPLATED) {
    var _tertutup = snapshot.data.tertutup;
    if (_tertutup.length == 0) {
      return Center(child: Text("Jadwal sidang tertutup belum tersedia"));
    } else {
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text("Hari / Tanggal"),
            subtitle: Text("${_tertutup[0].hari} / "
                "${_tertutup[0].tanggal} ${_tertutup[0].bulan} ${_tertutup[0].tahun}"),
          ),
          ListTile(
            title: Text("Jam"),
            subtitle: Text("${_tertutup[0].jam}"),
          ),
          ListTile(
            title: Text("Ruangan"),
            subtitle: Text("${_tertutup[0].ruangan}"),
          )
        ],
      );
    }
  } else {
    return SpinKitFadingCircle(
      color: Theme.of(context).buttonColor,
      size: 30,
    );
  }
}
//Tertutup Body---------------------------------------------------------------//

//Jadwal Page-----------------------------------------------------------------//

//Topik Page------------------------------------------------------------------//
class TopikPage extends StatefulWidget {
  TopikPage({Key key}) : super(key: key);

  @override
  _TopikPageState createState() => _TopikPageState();
}

class _TopikPageState extends State<TopikPage> {
  @override
  void initState() {
    super.initState();
    _taBloc.fetchTopik();
  }

  String _search;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: _taBloc.topikStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.status == Status.ERROR) {
                if (snapshot.data.message.contains("Unauthorised")) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                    child: Column(
                      children: [
                        Text(
                          "Sesi anda sudah habis \n"
                          "Silahkan melakukan proses Login kembali",
                          textAlign: TextAlign.center,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("Login"),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Terjadi kesalahan saat pengambilan Data"),
                  );
                }
              } else if (snapshot.data.status == Status.COMPLATED) {
                var _topik = snapshot.data.data.topik;
                if (_topik.length == 0) {
                  return Center(child: Text("Topik belum tersedia"));
                } else {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blokVertical * 2,
                                left: SizeConfig.blokHorizontal * 3,
                                right: SizeConfig.blokHorizontal * 3),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _search = value.trim();
                                });
                                print("value = $_search");
                              },
                              decoration: InputDecoration(
                                hintText: "Masukan topik yang ingin dicari",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blokVertical * 2,
                                left: SizeConfig.blokHorizontal * 2,
                                right: SizeConfig.blokHorizontal * 2),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _topik.length,
                              itemBuilder: (context, index) {
                                if (_search == null || _search.length == 0) {
                                  return ExpansionTile(
                                    title: Text(
                                        "${_topik[index].topik}".toUpperCase()),
                                    children: [
                                      ListTile(
                                        title: Text("Kategori"),
                                        subtitle:
                                            Text("${_topik[index].kategori}"),
                                      ),
                                      ListTile(
                                        title: Text("Dosen"),
                                        subtitle:
                                            Text("${_topik[index].dosen}"),
                                      )
                                    ],
                                  );
                                } else {
                                  if (_topik[index].topik.contains(_search) ||
                                      _topik[index]
                                          .kategori
                                          .contains(_search)) {
                                    return ExpansionTile(
                                      title: Text("${_topik[index].topik}"
                                          .toUpperCase()),
                                      children: [
                                        ListTile(
                                          title: Text("Kategori"),
                                          subtitle:
                                              Text("${_topik[index].kategori}"),
                                        ),
                                        ListTile(
                                          title: Text("Dosen"),
                                          subtitle:
                                              Text("${_topik[index].dosen}"),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return SpinKitFadingCircle(
                  color: Theme.of(context).buttonColor,
                );
              }
            } else {
              return SpinKitFadingCircle(
                color: Theme.of(context).buttonColor,
              );
            }
          }),
    );
  }
}
//Topik Page------------------------------------------------------------------//

//Pencarian Page--------------------------------------------------------------//
class PencarianPage extends StatefulWidget {
  PencarianPage({Key key}) : super(key: key);

  @override
  _PencarianPageState createState() => _PencarianPageState();
}

class _PencarianPageState extends State<PencarianPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          //Search Section----------------------------------------------------//
          Container(
            child: ListTile(
              title: TextField(
                onChanged: _taBloc.pencarianJudulSink,
                onSubmitted: (value) {
                  _taBloc.pencarianJudulSink(value);
                  _taBloc.fetchPencarianJudul();
                },
                decoration: InputDecoration(hintText: "Masukan kata kunci"),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).buttonColor,
                ),
                onPressed: () {
                  setState(() {
                    _taBloc.fetchPencarianJudul();
                  });
                },
              ),
            ),
          ),
          //Search Section----------------------------------------------------//

          //Body Section------------------------------------------------------//
          Container(
            child: StreamBuilder(
              stream: _taBloc.pencarianJudulStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.status == Status.ERROR) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: SizeConfig.blokVertical * 30,
                      ),
                      child: Text("Terjadi kesalahan saat mengambil data",
                          textAlign: TextAlign.center),
                    );
                  } else if (snapshot.data.status == Status.COMPLATED) {
                    var _pencarian = snapshot.data.data.pencarian;
                    if (_pencarian == null) {
                      print("Pencarian = $_pencarian");
                      return Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                        alignment: Alignment.center,
                        child: Text(
                          "Silahkan masukan kata kunci \n"
                          "untuk mencari judul yang diinginkan",
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      print("length = ${_pencarian.length}");
                      if (_pencarian.length != 0) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blokVertical * 2,
                              bottom: SizeConfig.blokVertical * 2),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _pencarian.length,
                              itemBuilder: (context, index) {
                                return LazyLoadingList(
                                    loadMore: () =>
                                        _taBloc.fetchPencarianJudul(),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 20,
                                          left: SizeConfig.blokHorizontal * 2,
                                          right: SizeConfig.blokHorizontal * 2),
                                      child: ListTile(
                                        title:
                                            Text("${_pencarian[index].judul}"),
                                        subtitle: Text(
                                            "${_pencarian[index].nim} | ${_pencarian[index].nama}"),
                                      ),
                                    ),
                                    index: 1,
                                    hasMore: true);
                              }),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blokVertical * 35),
                          alignment: Alignment.center,
                          child: Text(
                            "Tidak ditemukan judul dengan kata kunci tersebut\n"
                            "Silahkan masukan kata kunci lain",
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    }
                  } else {
                    return Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                      alignment: Alignment.center,
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).buttonColor,
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          )
          //Body Section------------------------------------------------------//
        ],
      ),
    );
  }
}
//Pencarian Page--------------------------------------------------------------//

//Seminar Terbuka-------------------------------------------------------------//
class SeminarTerbukaPage extends StatefulWidget {
  SeminarTerbukaPage({Key key}) : super(key: key);

  @override
  _SeminarTerbukaPageState createState() => _SeminarTerbukaPageState();
}

class _SeminarTerbukaPageState extends State<SeminarTerbukaPage> {
  @override
  void initState() {
    super.initState();
    _taBloc.fetchSeminarTerbuka();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _taBloc.seminarTerbukaStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == Status.ERROR) {
              if (snapshot.data.message.contains("Unauthorised")) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                  child: Column(
                    children: [
                      Text(
                        "Sesi anda sudah habis \n "
                        "Silahkan melakukan proses Login kembali",
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Login"),
                      )
                    ],
                  ),
                );
              } else {
                print("${snapshot.data.message}");
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                  child: Column(
                    children: [
                      Text(
                        "Terjadi kesalahan saat mengambil data \n "
                        "Silahkan coba beberapa saat lagi",
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Login"),
                      )
                    ],
                  ),
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              //snapshot.data.data.seminarTerbuka.length
              var _seminarTerbuka = snapshot.data.data.seminarTerbuka;
              if (_seminarTerbuka.length == 0) {
                return Center(
                  child: Text("Jadwal seminar terbuka belum tersedia"),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blokVertical * 3,
                      left: SizeConfig.blokHorizontal * 2,
                      right: SizeConfig.blokHorizontal * 2),
                  child: ListView.builder(
                    itemCount: _seminarTerbuka.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blokVertical * 2,
                            bottom: SizeConfig.blokVertical * 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).buttonColor)),
                        child: ExpansionTile(
                          title: Text("${_seminarTerbuka[index].nama}"),
                          subtitle: Text("${_seminarTerbuka[index].nim}"),
                          children: [
                            ListTile(
                              dense: true,
                              title: Text("Hari / Tanggal"),
                              subtitle: Text("${_seminarTerbuka[index].hari} / "
                                  " ${_seminarTerbuka[index].tanggal}"
                                  " ${_seminarTerbuka[index].bulan}"
                                  " ${_seminarTerbuka[index].tahun}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text("Jam"),
                              subtitle:
                                  Text("${_seminarTerbuka[index].jam} WITA"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text("Ruangan"),
                              subtitle:
                                  Text("${_seminarTerbuka[index].ruangan}"),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return SpinKitFadingCircle(
                color: Theme.of(context).buttonColor,
              );
            }
          } else {
            return SpinKitFadingCircle(
              color: Theme.of(context).buttonColor,
            );
          }
        },
      ),
    );
  }
}
//Seminar Terbuka-------------------------------------------------------------//
