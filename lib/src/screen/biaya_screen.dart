import 'package:intl/intl.dart';
import 'package:numerus/numerus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'login_screen.dart';
import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../widget/drawer_widget.dart';
import '../widget/settings_widget.dart';

class BiayaScreen extends StatefulWidget {
  BiayaScreen({Key key}) : super(key: key);

  @override
  _BiayaScreenState createState() => _BiayaScreenState();
}

class _BiayaScreenState extends State<BiayaScreen> {
  BiayaBloc _biayaBloc = BiayaBloc();

  @override
  void initState() {
    super.initState();
    _biayaBloc.fetchBiaya();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Informasi Pembayaran"),
        actions: [
          SettingsWidget(),
        ],
      ),
      drawer: DrawerWidget(),
      body: Container(
        child: StreamBuilder(
          stream: _biayaBloc.biayaStream,
          builder: (context, snapshot) {
            print("snapshot hasdata = ${snapshot.hasData}");
            if (snapshot.hasData) {
              if (snapshot.data.status == Status.ERROR) {
                if (snapshot.data.message.contains("Unauthorised")) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blokVertical * 30),
                          child: Text(
                            "Sesi anda telah habis \n Silahkan melakukan proses Login kembali",
                            textAlign: TextAlign.center,
                          ),
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
                //snapshot.data.data.biaya
                final currency = NumberFormat("#,###");
                return Container(
                  child: ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.data.biaya.length,
                        itemBuilder: (context, index) {
                          var total =
                              int.parse(snapshot.data.data.biaya[index].total);
                          var potongan = int.parse(
                              snapshot.data.data.biaya[index].potongan);
                          var bayar =
                              int.parse(snapshot.data.data.biaya[index].bayar);
                          var denda =
                              int.parse(snapshot.data.data.biaya[index].denda);
                          var semester = int.parse(
                              snapshot.data.data.biaya[index].semester);

                          return Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blokVertical * 4,
                                left: SizeConfig.blokHorizontal * 3,
                                right: SizeConfig.blokHorizontal * 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).buttonColor)),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  dense: true,
                                  title: Text("Semester"),
                                  subtitle: Text(
                                      "${semester.toRomanNumeralString()}"),
                                ),
                                ListTile(
                                  title: Text(
                                    "Tahun Ajaran",
                                  ),
                                  subtitle: Text(
                                      "${snapshot.data.data.biaya[index].tahunAjaran}"),
                                ),
                                ListTile(
                                  title: Text(
                                    "Total",
                                  ),
                                  subtitle:
                                      Text("Rp. ${currency.format(total)}"),
                                ),
                                ListTile(
                                  title: Text(
                                    "Potongan",
                                  ),
                                  subtitle:
                                      Text("Rp. ${currency.format(potongan)}"),
                                ),
                                ListTile(
                                  dense: true,
                                  title: Text("Bayar"),
                                  subtitle:
                                      Text("Rp. ${currency.format(bayar)}"),
                                ),
                                ListTile(
                                  dense: true,
                                  title: Text(
                                    "Denda",
                                  ),
                                  subtitle:
                                      Text("Rp. ${currency.format(denda)}"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blokVertical * 3,
                            left: SizeConfig.blokHorizontal * 2),
                        child: Text(
                            "*Tarif yang tertera belum termasuk denda. \n"
                            "Mohon untuk mengkonfirmasi kembali ke bagian keuangan untuk lebih detail"),
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
      ),
    );
  }
}
