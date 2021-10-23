import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../screen/login_screen.dart';
import '../widget/drawer_widget.dart';
import '../widget/settings_widget.dart';

PencarianBloc _pencarianBloc = PencarianBloc();

class PencarianScreen extends StatefulWidget {
  PencarianScreen({Key key}) : super(key: key);

  @override
  _PencarianScreenState createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Pencarian"),
            centerTitle: true,
            actions: [SettingsWidget()],
            bottom: TabBar(
              tabs: [Tab(text: "Mahasiswa"), Tab(text: "Dosen")],
            ),
          ),
          drawer: DrawerWidget(),
          body: TabBarView(
            children: [MahasiswaPage(), DosenPage()],
          ),
        ));
  }
}

class MahasiswaPage extends StatefulWidget {
  MahasiswaPage({Key key}) : super(key: key);

  @override
  _MahasiswaPageState createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
//Search Section--------------------------------------------------------------//
            child: ListTile(
              title: TextField(
                onChanged: _pencarianBloc.mahasiswaSink,
                onSubmitted: (value) {
                  _pencarianBloc.mahasiswaSink(value);
                  setState(() {
                    _pencarianBloc.getMahasiswa();
                  });
                },
                decoration: InputDecoration(hintText: "Masukan Nama atau NIM"),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).buttonColor,
                ),
                onPressed: () {
                  setState(() {
                    _pencarianBloc.getMahasiswa();
                  });
                },
              ),
            ),
          ),
//Search Section--------------------------------------------------------------//

//Hasil Body------------------------------------------------------------------//
          Container(
            margin: EdgeInsets.only(top: SizeConfig.blokVertical * 1),
            child: StreamBuilder(
              stream: _pencarianBloc.mahasiswaStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //Error-----------------------------------------------------//
                  if (snapshot.data.status == Status.ERROR) {
                    if (snapshot.data.message == "Unauthorised") {
                      return Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sesi anda telah habis \n"
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
                      print("snapshot error = ${snapshot.data.message}");
                      return Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Terjadi kesalahan saat melakukan pengambilan data \n"
                              "Silahkan coba lagi nanti",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  //Error-----------------------------------------------------//16
                  //Complated-------------------------------------------------//
                  else if (snapshot.data.status == Status.COMPLATED) {
                    var _mahasiswa = snapshot.data.data.mahasiswa;

                    if (_mahasiswa == null) {
                      return Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 35),
                        alignment: Alignment.center,
                        child: Text(
                          "Silahkan masukan Nama atau NIM mahasiswa \n"
                          "yang ingin dicari",
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blokHorizontal * 2,
                            right: SizeConfig.blokHorizontal * 2),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.data.mahasiswa.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data.data.mahasiswa[index].status ==
                                    "Lulus" ||
                                snapshot.data.data.mahasiswa[index].status ==
                                    "Aktif") {
                              return ListTile(
                                title: Text(
                                    "${snapshot.data.data.mahasiswa[index].nama}"),
                                subtitle: Text(
                                    "${snapshot.data.data.mahasiswa[index].nim} | "
                                    "${snapshot.data.data.mahasiswa[index].prodi}"),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      );
                    }
                  }
                  //Complated-------------------------------------------------//

                  //Loading---------------------------------------------------//
                  else {
                    return Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                      child: SpinKitFadingCircle(
                          color: Theme.of(context).buttonColor),
                    );
                  }
                  //Loading---------------------------------------------------//
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
//Hasil Body------------------------------------------------------------------//
  }
}

class DosenPage extends StatefulWidget {
  DosenPage({Key key}) : super(key: key);

  @override
  _DosenPageState createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
//Search Section--------------------------------------------------------------//
          Container(
            child: ListTile(
              title: TextField(
                onChanged: _pencarianBloc.dosenSink,
                onSubmitted: (value) {
                  _pencarianBloc.dosenSink(value);
                  _pencarianBloc.getDosen();
                },
                decoration: InputDecoration(hintText: "Masukan Nama Dosen"),
              ),
              trailing: IconButton(
                icon: Icon(Icons.search, color: Theme.of(context).buttonColor),
                onPressed: () {
                  _pencarianBloc.getDosen();
                },
              ),
            ),
          ),
//Search Section--------------------------------------------------------------//

//Hasil Body------------------------------------------------------------------//
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blokVertical * 1,
                left: SizeConfig.blokHorizontal * 2,
                right: SizeConfig.blokHorizontal * 2,
                bottom: SizeConfig.blokVertical * 2),
            child: StreamBuilder(
              stream: _pencarianBloc.dosenStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //Error-----------------------------------------------------//
                  if (snapshot.data.status == Status.ERROR) {
                    if (snapshot.data.message == "Unauthorised") {
                      return Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sesi anda telah habis \n"
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
                      print("snapshot error = ${snapshot.data.message}");
                      return Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Terjadi kesalahan saat melakukan pengambilan data \n"
                              "Silahkan coba lagi nanti",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  //Error-----------------------------------------------------//
                  else if (snapshot.data.status == Status.COMPLATED) {
                    //snapshot.data.data.dosen
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.data.dosen.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          expandedAlignment: Alignment.topLeft,
                          childrenPadding: EdgeInsets.only(
                              left: SizeConfig.blokHorizontal * 5),
                          title:
                              Text("${snapshot.data.data.dosen[index].nama}"),
                          trailing: Icon(Icons.more_vert),
                          children: [
                            ListTile(
                              title: Text("Jurusan"),
                              subtitle: Text(
                                "${snapshot.data.data.dosen[index].jurusan}",
                              ),
                            ),
                            ListTile(
                              title: Text("Telepon"),
                              subtitle: Text(
                                  "${snapshot.data.data.dosen[index].telepon}"),
                            ),
                            ListTile(
                              title: Text("Email"),
                              subtitle: Text(
                                  "${snapshot.data.data.dosen[index].email}"),
                            ),
                            ListTile(
                              title: Text("Alamat"),
                              subtitle: Text(
                                  "${snapshot.data.data.dosen[index].alamat}"),
                            ),
                            SizedBox(
                              height: SizeConfig.blokVertical * 2,
                            ),
                          ],
                        );
                      },
                    );
                  }
                  //Lading----------------------------------------------------//
                  else {
                    return Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.blokVertical * 30),
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).buttonColor,
                      ),
                    );
                  }
                }
                //Lading------------------------------------------------------//
                else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
//Hasil Body------------------------------------------------------------------//
  }
}
