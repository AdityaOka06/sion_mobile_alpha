import 'package:flutter/material.dart';

import '../util/size_config.dart';
import '../screen/login_screen.dart';

dialogWidget(IconData dialogIcon, Color dialogColor, String dialogContent,
    Widget dialogAction) {
  return AlertDialog(
    elevation: 0.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Icon(
      dialogIcon,
      color: dialogColor,
      size: SizeConfig.blokVertical * 10,
    ),
    content: Text(
      dialogContent,
      textAlign: TextAlign.center,
    ),
    actions: [dialogAction],
  );
}

sessionAlertWidget(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Icon(
            Icons.error,
            color: Colors.red,
            size: SizeConfig.blokVertical * 10,
          ),
          content: Text(
            "Waktu anda sudah habis \n Silahkan melakukan Login kembali",
            textAlign: TextAlign.center,
          ),
          actions: [
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
              child: Text("Login"),
            )
          ],
        );
      });
}
