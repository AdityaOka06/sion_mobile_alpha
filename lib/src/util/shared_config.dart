import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedConfig {
  SharedPreferences prefs;
  Map pref = {};

  Future _initShared() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  Future get(key) async {
    await _initShared();
    try {
      return json.decode(this.prefs.get(key));
    } catch (e) {
      return this.prefs.get(key);
    }
  }

  Future set(key, value) async {
    await _initShared();
    switch (value.runtimeType) {
      case String:
        {
          this.prefs.setString(key, value);
        }
        break;

      case int:
        {
          this.prefs.setInt(key, value);
        }
        break;

      case bool:
        {
          this.prefs.setBool(key, value);
        }
        break;

      case double:
        {
          this.prefs.setDouble(key, value);
        }
        break;

      case List:
        {
          this.prefs.setStringList(key, value);
        }
        break;

      default:
        {
          this.prefs.setString(key, jsonEncode(value.toJson()));
        }
    }
    this.pref.putIfAbsent(key, () => value);
  }

  Future remove(key) async {
    await _initShared();
    this.prefs.remove(key);
  }

  Future clear() async {
    await _initShared();
    this.prefs.clear();
  }
}
