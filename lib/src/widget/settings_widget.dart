import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alert_widget.dart';
import '../util/theme_config.dart';
import '../screen/login_screen.dart';

class SettingsMenu {
  static const Theme = "Theme";
  static const LogOut = "Log Out";
  static const List<String> menu = [Theme, LogOut];
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void selectAction(String choice) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (choice == "Theme") {
        changeBrightness(context);
      } else if (choice == "Log Out") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialogWidget(
                  Icons.help,
                  Colors.yellow,
                  "Apakah anda yakin ingin log out ?",
                  ButtonBar(
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Tidak"),
                      ),
                      FlatButton(
                        onPressed: () async {
                          pref.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Iya"),
                      )
                    ],
                  ));
            });
      }
    }

    return PopupMenuButton(
      icon: Icon(Icons.settings),
      color: Theme.of(context).scaffoldBackgroundColor,
      onSelected: selectAction,
      itemBuilder: (BuildContext context) {
        return SettingsMenu.menu.map((String choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
