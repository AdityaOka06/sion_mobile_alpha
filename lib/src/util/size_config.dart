import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double _screenHeight;
  static double _screenWidth;
  static double blokHorizontal;
  static double blokVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenHeight = _mediaQueryData.size.height;
    _screenWidth = _mediaQueryData.size.width;
    blokHorizontal = _screenWidth / 100;
    blokVertical = _screenHeight / 100;
  }
}
