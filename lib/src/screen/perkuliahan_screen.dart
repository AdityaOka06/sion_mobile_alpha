import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../screen/login_screen.dart';
import '../widget/drawer_widget.dart';
import '../widget/settings_widget.dart';

PerkuliahanBloc _perkuliahanBloc = PerkuliahanBloc();

class PerkuliahanScreen extends StatefulWidget {
  PerkuliahanScreen({Key key}) : super(key: key);

  @override
  _PerkuliahanScreenState createState() => _PerkuliahanScreenState();
}

class _PerkuliahanScreenState extends State<PerkuliahanScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Perkuliahan"),
            actions: [SettingsWidget()],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Jadwal Perkuliahan",
                ),
                Tab(
                  text: "KRS",
                ),
                Tab(
                  text: "KRS SP",
                ),
                Tab(
                  text: "UAS",
                ),
                Tab(
                  text: "Absensi",
                )
              ],
            ),
          ),
          drawer: DrawerWidget(),
          body: TabBarView(
            children: [
              JadwalScreen(),
              KrsScreen(),
              KrsSpScreen(),
              UasScreen(),
              AbsensiScreen()
            ],
          ),
        ));
  }
}

//Jadwal Screen---------------------------------------------------------------//

class JadwalScreen extends StatefulWidget {
  JadwalScreen({Key key}) : super(key: key);

  @override
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  @override
  void initState() {
    super.initState();
    _perkuliahanBloc.fetchJadwal();
    _perkuliahanBloc.fetchKrs();
  }

  @override
  Widget build(BuildContext context) {
    //snapshot.data.jadwal.data.jadwal[0].namaMatkul
    return Scaffold(
      body: StreamBuilder(
        stream: _perkuliahanBloc.jadwalSemesterStream,
        builder: (context, snapshot) {
          print("snapshot data = ${snapshot.hasData}");
          if (snapshot.hasData) {
            var _jadwal = snapshot.data.jadwal;
            var _krs = snapshot.data.krs;
            if (_jadwal.status == Status.ERROR) {
              if (_jadwal.message.contains("Unauthorised")) {
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
            } else if (_jadwal.status == Status.COMPLATED) {
              //_jadwal.data.jadwal
              return ListView(
                children: [
                  krsBody(context, _krs.data.krs),
                  jadwalBody(context, _jadwal.data.jadwal)
                ],
              );
            } else {
              return SpinKitFadingCircle(
                color: Theme.of(context).buttonColor,
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error = ${snapshot.error}"),
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

//Krs Body--------------------------------------------------------------------//
Widget krsBody(context, snapshot) {
  if (snapshot.length == 0) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: SizeConfig.blokVertical * 20),
      child: Text("KRS belum tersedia"),
    );
  } else {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.blokVertical * 3,
          left: SizeConfig.blokHorizontal * 2,
          right: SizeConfig.blokHorizontal * 2),
      child: InputDecorator(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).buttonColor),
          ),
          labelText: "KRS",
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text("${snapshot[index].namaMatkul}"),
              subtitle: Text("${snapshot[index].kodeMatkul}"),
              trailing: Icon(
                Icons.more_vert,
                color: Theme.of(context).buttonColor,
              ),
              children: [
                ListTile(
                  title: Text("SKS"),
                  subtitle: Text("${snapshot[index].sks}"),
                ),
                ListTile(
                  title: Text("Kode Kelas"),
                  subtitle: Text("${snapshot[index].kodeKelas}"),
                ),
                ListTile(
                  title: Text("Semester"),
                  subtitle: Text("${snapshot[index].semester1}"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
//Krs Body--------------------------------------------------------------------//

//Jadwal Body-----------------------------------------------------------------//
Widget jadwalBody(context, snapshot) {
  if (snapshot.length == 0) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: SizeConfig.blokVertical * 20),
      child: Text("Jadwal belum tersedia"),
    );
  } else {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.blokVertical * 3,
          left: SizeConfig.blokHorizontal * 2,
          right: SizeConfig.blokHorizontal * 2),
      child: InputDecorator(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).buttonColor),
          ),
          labelText: "Jadwal",
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text("${snapshot[index].namaMatkul}"),
              subtitle: Text("${snapshot[index].kodeMatkul}"),
              trailing: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).buttonColor,
              ),
              children: [
                ListTile(
                  title: Text("Hari"),
                  subtitle: Text("${snapshot[index].hari}"),
                ),
                ListTile(
                  title: Text("Jam"),
                  subtitle: Text("${snapshot[index].jam}"),
                ),
                ListTile(
                  title: Text("Kelas"),
                  subtitle: Text("${snapshot[index].kelas}"),
                ),
                ListTile(
                  title: Text("Ruangan"),
                  subtitle: Text("${snapshot[index].ruangan}"),
                ),
                ListTile(
                  title: Text("Nama Dosen"),
                  subtitle: Text("${snapshot[index].namaDosen}"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

//Jadwal Body-----------------------------------------------------------------//

//Jadwal Screen---------------------------------------------------------------//

//Krs All Screen--------------------------------------------------------------//

class KrsScreen extends StatefulWidget {
  KrsScreen({Key key}) : super(key: key);

  @override
  _KrsScreenState createState() => _KrsScreenState();
}

class _KrsScreenState extends State<KrsScreen> {
  @override
  void initState() {
    super.initState();
    _perkuliahanBloc.fetchKrsAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: _perkuliahanBloc.krsAllStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return Center(child: Text("${snapshot.data.status}"));
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
                    margin: EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                    child: Text(
                      "Terjadi kesalahan saat melakukan pengambilan data \n"
                      "Silahkan coba lagi",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              } else if (snapshot.data.status == Status.COMPLATED) {
                var _krsAll = snapshot.data.data.krs;
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 3,
                          left: SizeConfig.blokHorizontal * 2,
                          right: SizeConfig.blokHorizontal * 2,
                          bottom: SizeConfig.blokVertical * 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Theme.of(context).buttonColor)),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blokHorizontal * 2,
                            right: SizeConfig.blokHorizontal * 2),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _krsAll.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text("${_krsAll[index].namaMatkul}"),
                              subtitle: Text("${_krsAll[index].kodeMatkul}"),
                              trailing: Icon(
                                Icons.more_vert_rounded,
                                color: Theme.of(context).buttonColor,
                              ),
                              children: [
                                ListTile(
                                  title: Text("SKS"),
                                  subtitle: Text("${_krsAll[index].sks}"),
                                ),
                                ListTile(
                                  title: Text("Semester"),
                                  subtitle: Text("${_krsAll[index].semester}"),
                                ),
                                ListTile(
                                  title: Text("Kode Kelas"),
                                  subtitle: Text("${_krsAll[index].kodeKelas}"),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                  child: SpinKitFadingCircle(
                    color: Theme.of(context).buttonColor,
                  ),
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

//Krs All Screen--------------------------------------------------------------//

//KrsSp Screen----------------------------------------------------------------//

class KrsSpScreen extends StatefulWidget {
  KrsSpScreen({Key key}) : super(key: key);

  @override
  _KrsSpScreenState createState() => _KrsSpScreenState();
}

class _KrsSpScreenState extends State<KrsSpScreen> {
  @override
  void initState() {
    super.initState();
    _perkuliahanBloc.fetchKrsSp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _perkuliahanBloc.krsSpstream,
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
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                  child: Text(
                    "Terjadi kesalahan saat melakukan pengambilan data \n"
                    "Silahkan coba lagi",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              var _krsSp = snapshot.data.data.krsSp;
              if (_krsSp.length == 0) {
                return Center(child: Text("Jadwal KRS SP Belum Tersedia"));
              } else {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 2,
                          left: SizeConfig.blokHorizontal * 3,
                          right: SizeConfig.blokHorizontal * 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Theme.of(context).buttonColor)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _krsSp.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blokHorizontal * 3,
                                  right: SizeConfig.blokHorizontal * 3),
                              child: ExpansionTile(
                                title: Text("${_krsSp[index].namaMatkul}"),
                                subtitle: Text("${_krsSp[index].kodeMatkul}"),
                                children: [
                                  ListTile(
                                    title: Text("SKS"),
                                    subtitle: Text("${_krsSp[index].sks}"),
                                  ),
                                  ListTile(
                                    title: Text("Semester"),
                                    subtitle: Text("${_krsSp[index].semester}"),
                                  ),
                                  ListTile(
                                    title: Text("Kode Kelas"),
                                    subtitle:
                                        Text("${_krsSp[index].kodeKelas}"),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
            } else {
              return SpinKitFadingCircle(
                color: Theme.of(context).buttonColor,
              );
            }
          } else {
            return Container(
              alignment: Alignment.center,
              child: SpinKitFadingCircle(
                color: Theme.of(context).buttonColor,
              ),
            );
          }
        },
      ),
    );
  }
}

//KrsSp Screen----------------------------------------------------------------//

//Uas Screen------------------------------------------------------------------//

class UasScreen extends StatefulWidget {
  UasScreen({Key key}) : super(key: key);

  @override
  _UasScreenState createState() => _UasScreenState();
}

class _UasScreenState extends State<UasScreen> {
  @override
  void initState() {
    super.initState();
    _perkuliahanBloc.fetchUas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _perkuliahanBloc.uasStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == Status.ERROR) {
              if (snapshot.data.message.contains("Unauthorised")) {
                return Container(
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 30),
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
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                  child: Text(
                    "Terjadi kesalahan saat melakukan pengambilan data \n"
                    "Silahkan coba lagi",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              var _uas = snapshot.data.data.uas;
              if (_uas.length == 0) {
                return Center(
                  child: Text("Jadwal UAS belum tersedia",
                      textAlign: TextAlign.center),
                );
              } else {
                return ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Theme.of(context).buttonColor)),
                      margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 3,
                          left: SizeConfig.blokHorizontal * 3,
                          right: SizeConfig.blokHorizontal * 3),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _uas.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blokHorizontal * 2,
                                right: SizeConfig.blokHorizontal * 2),
                            child: ExpansionTile(
                              title: Text("${_uas[index].namaMatkul}"),
                              subtitle: Text("${_uas[index].kodeKelas}"),
                              children: [
                                ListTile(
                                  title: Text("Hari / Tanggal"),
                                  subtitle: Text(
                                      "${_uas[index].hari} ${_uas[index].tanggal}"),
                                ),
                                ListTile(
                                  title: Text("Jam"),
                                  subtitle: Text("${_uas[index].jam}"),
                                ),
                                ListTile(
                                  title: Text("Ruangan"),
                                  subtitle: Text("${_uas[index].ruangan}"),
                                ),
                                ListTile(
                                  title: Text("Kursi"),
                                  subtitle: Text("${_uas[index].kursi}"),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Container(
                alignment: Alignment.center,
                child: SpinKitFadingCircle(
                  color: Theme.of(context).buttonColor,
                ),
              );
            }
          } else {
            return SpinKitFadingCircle(color: Theme.of(context).buttonColor);
          }
        },
      ),
    );
  }
}

//Uas Screen------------------------------------------------------------------//

//Absensi Screen--------------------------------------------------------------//

class AbsensiScreen extends StatefulWidget {
  AbsensiScreen({Key key}) : super(key: key);

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  @override
  void initState() {
    super.initState();
    _perkuliahanBloc.fetchAbsensi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _perkuliahanBloc.absensiStream,
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
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                  child: Text(
                    "Terjadi kesalahan saat melakukan pengambilan data \n"
                    "Silahkan coba lagi",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              var _absensi = snapshot.data.data.absensi;
              if (snapshot.data.data.absensi.length == 0) {
                return Center(
                  child: Text("Absensi belum tersedia"),
                );
              } else {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 2,
                          left: SizeConfig.blokHorizontal * 2,
                          right: SizeConfig.blokHorizontal * 2,
                          bottom: SizeConfig.blokVertical * 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Theme.of(context).buttonColor)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _absensi.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blokHorizontal * 2,
                                right: SizeConfig.blokHorizontal * 2),
                            child: ListTile(
                              title: Text(
                                  "${_absensi[index].namaMatkul} \n${_absensi[index].kodeMatkul} \n"
                                  ""),
                              subtitle: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blokHorizontal * 4,
                                        right: SizeConfig.blokHorizontal * 4,
                                        bottom: SizeConfig.blokVertical * 1),
                                    child: Table(
                                      border: TableBorder.all(
                                          color: Theme.of(context).buttonColor),
                                      children: [
                                        TableRow(children: [
                                          for (int i = 1; i < 8; i++)
                                            Text("$i",
                                                textAlign: TextAlign.center),
                                          Text(
                                            "UTS",
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                            "${_absensi[index].absen1}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen2}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen3}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen4}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen5}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen6}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen7}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen8}",
                                            textAlign: TextAlign.center,
                                          )
                                        ]),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blokHorizontal * 4,
                                        right: SizeConfig.blokHorizontal * 4,
                                        bottom: SizeConfig.blokVertical * 1),
                                    child: Table(
                                      border: TableBorder.all(
                                          color: Theme.of(context).buttonColor),
                                      children: [
                                        TableRow(children: [
                                          for (int i = 8; i <= 14; i++)
                                            Text("$i",
                                                textAlign: TextAlign.center),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                            "${_absensi[index].absen9}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen10}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen11}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen12}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen13}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${_absensi[index].absen14}",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text("${_absensi[index].absen15}",
                                              textAlign: TextAlign.center),
                                        ])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

//Absensi Screen--------------------------------------------------------------//
