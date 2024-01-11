
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<bool> loginUser(String username, String password) async {
    // Gantilah ini dengan logika autentikasi yang sesuai dengan kebutuhan Anda
    if (username == "user" && password == "password") {
      // Simpan informasi login di SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("username", username);
      prefs.setBool("isLoggedIn", true);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
    await prefs.setBool("isLoggedIn", false);
  }
}