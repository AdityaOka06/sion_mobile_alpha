import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'login_screen.dart';
import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../widget/drawer_widget.dart';
import '../widget/settings_widget.dart';

AkademikBloc _akademikBloc = AkademikBloc();

class AkademikScreen extends StatefulWidget {
  AkademikScreen({Key key}) : super(key: key);

  @override
  _AkademikScreenState createState() => _AkademikScreenState();
}

class _AkademikScreenState extends State<AkademikScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Akademik"),
            actions: [SettingsWidget()],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Prasyarat",
                ),
                Tab(
                  text: "Perwalian",
                ),
                Tab(
                  text: "Polling",
                ),
                Tab(
                  text: "Sisa Matakuliah",
                )
              ],
            ),
          ),
          drawer: DrawerWidget(),
          body: TabBarView(
            children: [
              PrasyaratScreen(),
              PerwalianScreen(),
              PollingScreen(),
              SisaMatakuliahScreen()
            ],
          ),
        ));
  }
}

//Prasyarat Screen------------------------------------------------------------//
class PrasyaratScreen extends StatefulWidget {
  PrasyaratScreen({Key key}) : super(key: key);

  @override
  _PrasyaratScreenState createState() => _PrasyaratScreenState();
}

class _PrasyaratScreenState extends State<PrasyaratScreen> {
  @override
  void initState() {
    super.initState();
    _akademikBloc.fetchPrasyarat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _akademikBloc.prasyaratStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == Status.ERROR) {
              if (snapshot.data.message.contains("Unauthorised")) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sesi anda telah habis \n Silahkan melakukan proses Login kembali",
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
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
                  margin: EdgeInsets.only(
                    top: SizeConfig.blokVertical * 2,
                  ),
                  child: Center(
                    child: Text(
                      "Terjadi kesalahan saat melakukan pengambilan data \n Silahkan coba lagi nanti",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              var _prasyarat = snapshot.data.data.prasyarat;
              var _nonPrasyarat = snapshot.data.data.nonPrasyarat;
              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blokVertical * 3,
                        left: SizeConfig.blokHorizontal * 2,
                        right: SizeConfig.blokHorizontal * 2,
                        bottom: SizeConfig.blokVertical * 2),
                    child: InputDecorator(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Theme.of(context).buttonColor)),
                          labelText: "Prasyarat"),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _prasyarat.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text("${_prasyarat[index].namaMatkul}"),
                            subtitle: Text("${_prasyarat[index].kodeMatkul}"),
                            trailing: Icon(
                              Icons.more_vert_rounded,
                              color: Theme.of(context).buttonColor,
                            ),
                            children: [
                              ListTile(
                                title: Text("Semester"),
                                subtitle: Text("${_prasyarat[index].semester}"),
                              ),
                              ListTile(
                                title: Text("SKS"),
                                subtitle: Text('${_prasyarat[index].sks}'),
                              ),
                              ListTile(
                                title: Text("Syarat"),
                                subtitle: Text("${_prasyarat[index].syarat}"),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blokVertical * 3,
                        left: SizeConfig.blokHorizontal * 2,
                        right: SizeConfig.blokHorizontal * 2,
                        bottom: SizeConfig.blokVertical * 2),
                    child: InputDecorator(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Theme.of(context).buttonColor)),
                          labelText: "Non Prasyarat"),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _prasyarat.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text("${_nonPrasyarat[index].namaMatkul}"),
                            subtitle:
                                Text("${_nonPrasyarat[index].kodeMatkul}"),
                            trailing: Icon(
                              Icons.more_vert_rounded,
                              color: Theme.of(context).buttonColor,
                            ),
                            children: [
                              ListTile(
                                title: Text("Semester"),
                                subtitle:
                                    Text("${_nonPrasyarat[index].semester}"),
                              ),
                              ListTile(
                                title: Text("SKS"),
                                subtitle: Text('${_nonPrasyarat[index].sks}'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
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
//Prasyarat Screen------------------------------------------------------------//

//Perwalian Screen------------------------------------------------------------//
class PerwalianScreen extends StatefulWidget {
  PerwalianScreen({Key key}) : super(key: key);

  @override
  _PerwalianScreenState createState() => _PerwalianScreenState();
}

class _PerwalianScreenState extends State<PerwalianScreen> {
  @override
  void initState() {
    super.initState();
    _akademikBloc.fetchPerwalian();
  }

  @override
  Widget build(BuildContext context) {
    //snapshot.data.data.perwalian == null
    return Container(
      child: StreamBuilder(
          stream: _akademikBloc.perwalianStream,
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
                var _perwalian = snapshot.data.data.perwalian;
                if (_perwalian == null) {
                  return Center(
                    child: Text("Jadwal perwalian belum tersedia"),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blokVertical * 2,
                            left: SizeConfig.blokHorizontal * 3,
                            right: SizeConfig.blokHorizontal * 3),
                        child: InputDecorator(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).buttonColor),
                              ),
                              labelText: "Jadwal Perwalian"),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                title: Text("Semester"),
                                subtitle: Text("${_perwalian.semester}"),
                              ),
                              ListTile(
                                title: Text("Tanggal"),
                                subtitle: Text("${_perwalian.tanggal}"),
                              ),
                              ListTile(
                                title: Text("Jam"),
                                subtitle: Text("${_perwalian.jam}"),
                              ),
                              ListTile(
                                title: Text("Ruangan"),
                                subtitle: Text("${_perwalian.ruangan}"),
                              )
                            ],
                          ),
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
          }),
    );
  }
}
//Perwalian Screen------------------------------------------------------------//

//Polling Screen--------------------------------------------------------------//
class PollingScreen extends StatefulWidget {
  PollingScreen({Key key}) : super(key: key);

  @override
  _PollingScreenState createState() => _PollingScreenState();
}

class _PollingScreenState extends State<PollingScreen> {
  @override
  void initState() {
    super.initState();
    _akademikBloc.fetchPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _akademikBloc.pollingStream,
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
              var _polling = snapshot.data.data.polling;
              if (_polling.length == 0) {
                return Center(
                    child: Text(
                  "Anda tidak berpartisipasi dalam polling",
                  textAlign: TextAlign.center,
                ));
              } else {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 2,
                          left: SizeConfig.blokHorizontal * 3,
                          right: SizeConfig.blokHorizontal * 3),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Theme.of(context).buttonColor),
                            ),
                            labelText: "Hasil Polling"),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _polling.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${_polling[index].kodeMatkul}   ${_polling[index].namaMatkul}"),
                              subtitle: Text(
                                  "Semester = ${_polling[index].semester}   SKS = ${_polling[index].sks}"),
                            );
                          },
                        ),
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
//Polling Screen--------------------------------------------------------------//

//Sisa Matakuliah Screen------------------------------------------------------//
class SisaMatakuliahScreen extends StatefulWidget {
  SisaMatakuliahScreen({Key key}) : super(key: key);

  @override
  _SisaMatakuliahScreenState createState() => _SisaMatakuliahScreenState();
}

class _SisaMatakuliahScreenState extends State<SisaMatakuliahScreen> {
  @override
  void initState() {
    super.initState();
    _akademikBloc.fetchSisaMatakuliah();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _akademikBloc.sisaMatkulStream,
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
              var _sisaMatkul = snapshot.data.data.sisaMatkul;
              if (_sisaMatkul.length == 0) {
                return Center(child: Text("Tidak ada sisa matakuliah"));
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
                        itemCount: _sisaMatkul.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                "${_sisaMatkul[index].kodeMatkul}   ${_sisaMatkul[index].namaMatkul}"),
                            subtitle: Text(
                                "Semester =  ${_sisaMatkul[index].semester}   SKS =  ${_sisaMatkul[index].sks}"),
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
//Sisa Matakuliah Screen------------------------------------------------------//
