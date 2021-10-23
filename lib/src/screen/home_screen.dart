import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../screen/login_screen.dart';
import '../widget/alert_widget.dart';
import '../widget/drawer_widget.dart';
import '../widget/download_widget.dart';
import '../widget/settings_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PengumumanBloc _pengumumanBloc = PengumumanBloc();

  @override
  void initState() {
    super.initState();
    _pengumumanBloc.fetchPengumuman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [SettingsWidget()],
      ),
      drawer: DrawerWidget(),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: StreamBuilder(
          stream: _pengumumanBloc.pengumumanStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.status == Status.ERROR) {
                if (snapshot.data.message.contains("Unauthorised")) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sesi anda telah habis \n Silahkan melakukan proses Login kembali",
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
                  print("${snapshot.data.data}");
                  return Center(
                    child: Text(
                      "Terjadi kesalahan saat melakukan pengambilan data \n"
                      "Silahkan coba lagi nanti",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              } else if (snapshot.data.status == Status.COMPLATED) {
                var _pengumuman = snapshot.data.data.pengumuman;
//Pengumuman Body-------------------------------------------------------------//
                return Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      //Logo Section----------------------------------------//
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 2),
                        height: SizeConfig.blokVertical * 30,
                        child: Image.asset("assets/logo/logo1.png"),
                      ),
                      //Logo Section----------------------------------------//

                      //Pengumuman Penting----------------------------------//
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blokVertical * 3,
                          left: SizeConfig.blokHorizontal * 2,
                          right: SizeConfig.blokHorizontal * 2,
                          bottom: SizeConfig.blokVertical * 2,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _pengumuman.length,
                          itemBuilder: (context, index) {
                            if (_pengumuman[index].prioritas == "1") {
                              return ListTile(
                                leading: Icon(
                                  Icons.announcement,
                                  color: Colors.red,
                                ),
                                title: Text("${_pengumuman[index].judul}"),
                                trailing: (_pengumuman[index].pengumuman !=
                                            "" ||
                                        _pengumuman[index].dirUpload != null)
                                    ? Icon(Icons.more_vert_rounded,
                                        color: Colors.red)
                                    : null,
                                onTap: () {
                                  if (_pengumuman[index].pengumuman != "" ||
                                      _pengumuman[index].dirUpload != null) {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 0.0,
                                            title: Text(
                                                "${_pengumuman[index].judul}"),
                                            content: Text(
                                                "${_pengumuman[index].pengumuman}"),
                                            actions: [
                                              (_pengumuman[index].dirUpload !=
                                                      null)
                                                  ? FlatButton(
                                                      onPressed: () {
                                                        downloadWidget(
                                                            context,
                                                            "https://sion.stikom-bali.ac.id/${_pengumuman[index].dirUpload}",
                                                            "${_pengumuman[index].fileName}");
                                                      },
                                                      child: Text("Download"),
                                                    )
                                                  : Container()
                                            ],
                                          );
                                        });
                                  } else {
                                    return null;
                                  }
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      //Pengumuman Penting----------------------------------//

                      //Pengumuman Biasa------------------------------------//
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blokVertical * 1,
                            left: SizeConfig.blokHorizontal * 2,
                            right: SizeConfig.blokHorizontal * 2,
                            bottom: SizeConfig.blokVertical * 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context).buttonColor)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _pengumuman.length,
                          itemBuilder: (context, index) {
                            if (_pengumuman[index].prioritas == "0") {
                              return ListTile(
                                leading: Icon(
                                  Icons.campaign,
                                  color: Theme.of(context).buttonColor,
                                ),
                                title: Text("${_pengumuman[index].judul}"),
                                trailing: (_pengumuman[index].pengumuman !=
                                            "" ||
                                        _pengumuman[index].dirUpload != null)
                                    ? Icon(Icons.more_vert_rounded,
                                        color: Theme.of(context).buttonColor)
                                    : null,
                                onTap: () {
                                  if (_pengumuman[index].pengumuman != "" ||
                                      _pengumuman[index].dirUpload != null) {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 0.0,
                                            title: Text(
                                                "${_pengumuman[index].judul}"),
                                            content: Text(
                                                "${_pengumuman[index].pengumuman}"),
                                            actions: [
                                              (_pengumuman[index].dirUpload !=
                                                      null)
                                                  ? FlatButton(
                                                      onPressed: () {
                                                        downloadWidget(
                                                            context,
                                                            "https://sion.stikom-bali.ac.id/${_pengumuman[index].dirUpload}",
                                                            "${_pengumuman[index].fileName}");
                                                      },
                                                      child: Text("Download"),
                                                    )
                                                  : Container()
                                            ],
                                          );
                                        });
                                  } else {
                                    return null;
                                  }
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      //Pengumuman Biasa------------------------------------//

//Pengumuman Body-------------------------------------------------------------//
                    ],
                  ),
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
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogWidget(
              Icons.help,
              Colors.yellow,
              "Apakah anda yakin untuk keluar ?",
              ButtonBar(
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Tidak")),
                  FlatButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("Iya"),
                  )
                ],
              ));
        });
  }

  toastShow() {
    Fluttertoast.showToast(
        msg: "Downloading",
        backgroundColor: Theme.of(context).buttonColor,
        textColor: Theme.of(context).accentColor,
        toastLength: Toast.LENGTH_LONG);
  }
}
