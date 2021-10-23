import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sion_app/src/bloc/biodata_bloc.dart';

import '../bloc/bloc.dart';
import '../util/size_config.dart';

import '../screen/kp_screen.dart';
import '../screen/ta_screen.dart';
import '../screen/home_screen.dart';
import '../screen/biaya_screen.dart';
import '../screen/nilai_screen.dart';
import '../screen/login_screen.dart';
import '../screen/biodata_screen.dart';
import '../screen/akademik_screen.dart';
import '../screen/pencarian_screen.dart';
import '../screen/perkuliahan_screen.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  BiodataBloc _biodataBloc = BiodataBloc();

  @override
  void initState() {
    super.initState();
    _biodataBloc.getBiodata();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: StreamBuilder(
        stream: _biodataBloc.biodataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == Status.ERROR) {
              if (snapshot.data.message == "Unauthorised") {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sesi anda telah habis silahkan melakukan proses Login kembali \n"
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
                );
              } else {
                print("snapshot error = ${snapshot.data.message}");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Terjadi kesalahan saat melakukan pengambilan data \n"
                      "Silahkan coba lagi nanti",
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              }
            } else if (snapshot.data.status == Status.COMPLATED) {
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BiodataScreen(
                                    biodata: snapshot.data.data)));
                      },
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: CircleAvatar(
                          radius: SizeConfig.blokVertical * 4,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).buttonColor,
                            size: SizeConfig.blokVertical * 6,
                          ),
                        ),
                        accountName: Text("${snapshot.data.data.biodata.nama}"),
                        accountEmail: Text("${snapshot.data.data.biodata.nim}"),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Home"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Pencarian"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PencarianScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.account_balance,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Akademik"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AkademikScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Perkuliahan"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PerkuliahanScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.font_download,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Nilai"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NilaiScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.work,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Kerja Praktek"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KpScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Tugas Akhir"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.attach_money,
                        color: Theme.of(context).buttonColor,
                      ),
                      title: Text("Informasi Pembayaran"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BiayaScreen()));
                      },
                    ),
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
    );
  }
}
