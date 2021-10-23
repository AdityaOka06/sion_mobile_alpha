import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

ThemeData themeConfig(Brightness brightness) {
  return brightness == Brightness.dark
      ? ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          primaryColor: HexColor("#3a424c"),
          //accentColor: HexColor("#333b45"),
          //accentColor: HexColor("#1eddcd"),
          accentColor: Colors.white,
          scaffoldBackgroundColor: HexColor("#1c2426"),
          buttonColor: HexColor("#1eddcd"),
          buttonTheme: ButtonThemeData(
              buttonColor: HexColor("#1eddcd"),
              focusColor: HexColor("#1eddcd"),
              textTheme: ButtonTextTheme.normal),
          iconTheme: IconThemeData(
            color: HexColor("#7d838c"),
          ),
          cardColor: HexColor("#333b44"),
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#1eddcd"))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#1eddcd")))),
          backgroundColor: HexColor("#1d2025"))
      : ThemeData.light().copyWith(
          brightness: Brightness.light,
          primaryColor: HexColor("#185791"),
          scaffoldBackgroundColor: Colors.white,
          //accentColor: HexColor("#064278"),
          accentColor: Colors.black,
          buttonColor: Colors.blue[500],
          cardColor: Colors.grey[300],
          iconTheme: IconThemeData(color: Colors.white),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue[500],
              focusColor: Colors.blue[500],
              textTheme: ButtonTextTheme.normal),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[500])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[500])),
          ),
        );
}

void changeBrightness(context) async {
  DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark);
}
