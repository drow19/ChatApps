import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static String sharedUserLogin = "ISLOGGIN";
  static String sharedUserName = "USERNAME";
  static String sharedUserEmail = "EMAIL";

  //store data to sharedPreferences

  static Future<void> setUserLogin(bool isLogin) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return await shared.setBool(sharedUserLogin, isLogin);
  }

  static Future<void> setUserName(String username) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return await shared.setString(sharedUserName, username);
  }

  static Future<void> setUserEmail(String email) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return await shared.setString(sharedUserEmail, email);
  }

  //get data from sharedPreferences

  static Future<bool> getUserLogin() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return await shared.getBool(sharedUserLogin);
  }

  static Future<String> getUserName() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return await shared.getString(sharedUserName);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return await shared.getString(sharedUserEmail);
  }
}
