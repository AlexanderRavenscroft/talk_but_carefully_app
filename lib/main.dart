import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import required for SystemChrome
import 'screens/splash_screen.dart';

void main() {
  // Set preferred orientations before running the app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadaj Ale Ostrożnie',
      home: SplashScreen(),
    );
  }
}
