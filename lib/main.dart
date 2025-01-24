import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import required for SystemChrome
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'logic/provider.dart'; // Import your provider file
import 'services/preference_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:gadajaleostroznie/logic/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized

  // Load preferences and app version concurrently
  await Future.wait([
    PreferenceService.loadPreferences(),  // Load preferences before the app starts
    getAppVersion(),                      // Initialize app version and build number
  ]);

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load all text files concurrently using Future.wait
  await Future.wait(textFiles.keys.map((path) => loadText(path)));

  // Once everything is done, run the app
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ToggleProvider()),
          ChangeNotifierProvider(create: (context) => RefreshProvider()),
        ],
        child: MyApp(), // Pass loaded text to the app
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadaj ale Ostrożnie',
      home: SplashScreen(),
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling, // Disable system font scaling
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
