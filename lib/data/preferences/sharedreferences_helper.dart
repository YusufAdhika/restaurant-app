import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> getDailyReminder() async {
    var sharedpref = await SharedPreferences.getInstance();
    var token = sharedpref.getBool("remainder") ?? false;
    return token;
  }

  static Future<void> setDailyReminder(bool value) async {
    var sharepref = await SharedPreferences.getInstance();
    sharepref.setBool("remainder", value);
  }
}
