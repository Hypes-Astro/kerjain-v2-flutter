import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String keyLoggedIn = "isLoggedIn";

  Future<bool> login(String email, String password) async {
    if (email == "alifanwar@gmail.com" && password == "123") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(keyLoggedIn, true);
      return true;
    }
    return false;
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyLoggedIn) ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyLoggedIn, false);
  }
}
