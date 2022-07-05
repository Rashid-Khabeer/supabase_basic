import 'package:shared_preferences/shared_preferences.dart';

abstract class AppData {
  AppData._();

  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> insertId(String id) {
    return _preferences.setString('id', id);
  }

  static String get id => _preferences.getString('id') ?? '';

  static bool get isLogin => _preferences.getString('id')?.isNotEmpty ?? false;
}
