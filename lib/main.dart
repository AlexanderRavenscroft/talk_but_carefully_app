import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import required for SystemChrome
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'logic/provider.dart'; // Import your provider file
import 'services/preference_service.dart';

void main() {

  // Add this line to load preferences
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceService.loadPreferences();

  // Set preferred orientations before running the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          // Adding both the ToggleProvider and RefreshProvider
          ChangeNotifierProvider(create: (context) => ToggleProvider()),
          ChangeNotifierProvider(create: (context) => RefreshProvider()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadaj ale Ostrożnie',
      home: SplashScreen(),
    );
  }
}
