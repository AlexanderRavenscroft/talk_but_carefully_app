import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  // Load sound preference
  static Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GameSounds.soundToggled = prefs.getBool('soundToggled') ?? true;
  }

  // Load language preference
  static Future<String> loadLocalePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageCode') ?? 'en';
  }


  // Save sound setting
  static Future<void> savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Save language setting
  static Future<void> saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }
}
