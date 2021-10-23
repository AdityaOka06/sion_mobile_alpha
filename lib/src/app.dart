import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sion_app/src/screen/splash_screen.dart';

import 'util/theme_config.dart';

class SionApp extends StatefulWidget {
  SionApp({Key key}) : super(key: key);

  @override
  _SionAppState createState() => _SionAppState();
}

class _SionAppState extends State<SionApp> {
  Image logo1 = Image.asset("assets/logo/logo1.png");
  Image logo4 = Image.asset("assets/logo/logo4.png");

  @override
  void initState() {
    _removeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(logo1.image, context);
    precacheImage(logo4.image, context);
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => themeConfig(brightness),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }

  _removeData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.clear();
  }
}
