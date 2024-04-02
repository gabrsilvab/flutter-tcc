import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static Future<int> retornarLogs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? entrou = prefs.getInt('entrou');

    entrou ??= 0;

    if (entrou == 0) {
      return 6;
    }

    return 3;
  }

  static void logar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int logs = await retornarLogs();

    await prefs.setInt('entrou', logs + 1);
  }
}
