import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveStringPrefer(
      {required String keyName, required String value}) async {
    sharedPreferences?.setString(keyName, value);
  }

  static Future<String> getStringPrefer(String keyName) async {
    return sharedPreferences?.getString(keyName) ?? '';
  }
}
