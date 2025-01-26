// Setup the shared_prefrences to keep value of soundToggled even after app close
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gadajaleostroznie/core/globals.dart'; // Access global variables

class PreferenceService {
  // Load all preferences into global variables
  static Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load soundToggled preference, default to true
    soundToggled = prefs.getBool('soundToggled') ?? true;

  }

  // Save a specific preference
  static Future<void> savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value); // Save the value to persistent storage
  }
}
