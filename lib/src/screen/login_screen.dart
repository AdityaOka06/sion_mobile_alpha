import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_screen.dart';
import '../bloc/bloc.dart';
import '../util/size_config.dart';
import '../widget/alert_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc = LoginBloc();
  BiodataBloc _biodataBloc = BiodataBloc();
  static bool _obsecureValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: ListView(
          children: [
//LogoSection-----------------------------------------------------------------//
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blokVertical * 10),
              height: SizeConfig.blokVertical * 35,
              child: Image.asset("assets/logo/logo1.png"),
            ),
//LogoSection-----------------------------------------------------------------//

//InputSection----------------------------------------------------------------//
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blokVertical * 5,
                  left: SizeConfig.blokHorizontal * 7,
                  right: SizeConfig.blokHorizontal * 7),
              child: Column(
                children: [
                  //NIM Input-----------------------------------------------------//
                  TextField(
                    onChanged: _loginBloc.usernameSink,
                    onSubmitted: (value) {
                      _loginBloc.usernameSink(value);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            color: Theme.of(context).buttonColor),
                        hintText: "NIM"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //NIM Input-----------------------------------------------------//
                  TextField(
                    onChanged: _loginBloc.passwordSink,
                    onSubmitted: (value) {
                      _loginBloc.passwordSink(value);
                    },
                    obscureText: _obsecureValue,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                            color: Theme.of(context).buttonColor),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecureValue = !_obsecureValue;
                            });
                          },
                          icon: Icon((_obsecureValue == true)
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                  ),
                ],
              ),
            ),
//InputSection----------------------------------------------------------------//

//Lupa Password Section-------------------------------------------------------//
            Container(
              margin: EdgeInsets.only(top: 9),
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return dialogWidget(
                            Icons.help,
                            Colors.yellow,
                            "Jika anda lupa password, atau mengalami kendala saat Login \n"
                            "\n"
                            "Silahkan hubungi bagian PUSKOMJAR Bagian Sistem Informasi",
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Tutup"),
                            ));
                      });
                },
                child: Text(
                  "Lupa Password ?",
                  style: TextStyle(color: Theme.of(context).buttonColor),
                ),
              ),
            ),
//Lupa Password Section-------------------------------------------------------//

//LoginButton Section---------------------------------------------------------//
            Container(
              margin: EdgeInsets.only(
                  top: 9,
                  left: SizeConfig.blokHorizontal * 7,
                  right: SizeConfig.blokHorizontal * 7),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _loginBloc.fetchToken();
                  });
//Login Function and Alert----------------------------------------------------//
                  return showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return StreamBuilder(
                          stream: _loginBloc.loginStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.status == Status.COMPLATED) {
                                _biodataBloc.fetchBiodata();
                                Timer(
                                    Duration(seconds: 0),
                                    () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen())));
                                return Container();
                              } else if (snapshot.data.status == Status.ERROR) {
                                if (snapshot.data.message == "Unauthorised") {
                                  return dialogWidget(
                                      Icons.error,
                                      Colors.red,
                                      "Kombinasi NIM dan Password yang anda masukan salah \n"
                                      "Silahkan memasukan kombinasi yang benar",
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Tutup")));
                                } else if (snapshot.data.message ==
                                    "Method not Allowed") {
                                  return dialogWidget(
                                      Icons.error,
                                      Colors.red,
                                      "NIM atau Password yang anda masukan tidak sesuai dengan ketentuan \n"
                                      "Silahkan memasukan NIM dan Password sesuai dengan ketentuan",
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Tutup")));
                                } else if (snapshot.data.message ==
                                    "No Internet Connection") {
                                  return dialogWidget(
                                      Icons.error,
                                      Colors.red,
                                      "Terjadi kesalahan saat melakukan proses login \n"
                                      "Silahkan periksa jaringan internet anda kembali",
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Tutup"),
                                      ));
                                } else {
                                  return dialogWidget(
                                      Icons.error,
                                      Colors.red,
                                      "Terjadi kesalahan saat melakukan proses login \n"
                                      "Coba lagi nanti",
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Tutup")));
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
                        );
                      });
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
//LoginButton Section---------------------------------------------------------//
          ],
        ),
      ),
    );
  }

  Future<Null> _onWillPop() {
    setState(() {
      exit(0);
    });
    return null;
  }
}
