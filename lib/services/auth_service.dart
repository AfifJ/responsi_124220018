import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String?> login(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (username == 'afif' && password == 'afif') {
      prefs.setString('username', username);
      return username;
    }
    return null;
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('username');
    } catch (e) {
      print('Logout error $e');
    }
  }
}
