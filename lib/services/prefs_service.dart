import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  // Firebase Token
  static Future<bool> saveFCM(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('fcm_token', fcmToken);
  }

  static Future<String> loadFCM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('fcm_token');
    return token!;
  }
}