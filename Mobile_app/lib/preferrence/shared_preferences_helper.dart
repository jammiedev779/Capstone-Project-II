import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _patientIdKey = 'patientId';

  static Future<void> savePatientId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_patientIdKey, id);
  }

  static Future<int?> getPatientId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_patientIdKey);
  }

  static Future<void> removePatientId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_patientIdKey);
  }
}
