import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  final SharedPreferences prefs;

  TokenStorage(this.prefs);

  Future<void> saveTokens(String access, String refresh) async {
    await prefs.setString('access', access);
    await prefs.setString('refresh', refresh);
  }

  Future<String?> getAccessToken() async => prefs.getString('access');
  Future<String?> getRefreshToken() async => prefs.getString('refresh');

  Future<void> clear() async {
    await prefs.remove('access');
    await prefs.remove('refresh');
  }
}

