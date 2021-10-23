import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../screen/login_screen.dart';
import '../widget/drawer_widget.dart';
import '../widget/settings_widget.dart';

class KpScreen extends StatefulWidget {
  KpScreen({Key key}) : super(key: key);

  @override
  _KpScreenState createState() => _KpScreenState();
}

class _KpScreenState extends State<KpScreen> {
  KpBloc _kpBloc = KpBloc();

  @override
  void initState() {
    super.initState();
    _kpBloc.getKp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kerja Praktek"),
        actions: [SettingsWidget()],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          _onRefresh();
        },
        child: Container(
          child: StreamBuilder(
            stream: _kpBloc.kpStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.status == Status.ERROR) {
                  print("${snapshot.data.message}");
                  if (snapshot.data.message.contains("Unauthorised")) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sesi anda telah habis \n"
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
                    return Center(
                      child: Text(
                        "Terjadi kesalahaan saat melakukan pengambilan data \n"
                        "Silahkan coba lagi nanti,",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                } else if (snapshot.data.status == Status.COMPLATED) {
                  var _kp = snapshot.data.data;
                  if (_kp.status.contains("belum mendaftar")) {
                    return Center(
                      child: Text("${_kp.status}"),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blokVertical * 3,
                              left: SizeConfig.blokHorizontal * 2,
                              right: SizeConfig.blokHorizontal * 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).buttonColor)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  "Status:",
                                ),
                                subtitle: Text(
                                  "${snapshot.data.data.status}",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              (snapshot.data.data.statusAnggota == " ")
                                  ? Container()
                                  : ListTile(
                                      title: Text(
                                        "Anggota:",
                                      ),
                                      subtitle: Text(
                                        "${snapshot.data.data.statusAnggota}",
                                        textAlign: TextAlign.left,
                                      ),
                                    )
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
        ),
      ),
    );
  }

  Future<Null> _onRefresh() {
    setState(() {
      _kpBloc.getKp();
    });
    return null;
  }
}
