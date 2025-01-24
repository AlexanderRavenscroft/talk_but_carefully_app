import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import required for SystemChrome
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'logic/provider.dart'; // Import your provider file
import 'services/preference_service.dart';
import 'package:device_preview/device_preview.dart';
void main() {
  // Ensure Flutter bindings are initialized before accessing native code or preferences
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceService.loadPreferences();

  // Set preferred orientations before running the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      DevicePreview(
      enabled: true,
         builder: (context) => MultiProvider(
           providers: [
             // Adding both the ToggleProvider and RefreshProvider
             ChangeNotifierProvider(create: (context) => ToggleProvider()),
             ChangeNotifierProvider(create: (context) => RefreshProvider()),
          ],
          child: MyApp(), // Your main app widget
        ),
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
      builder: (context, child) {
        // Use LayoutBuilder to manage layout adaptability
        return LayoutBuilder(
          builder: (context, constraints) {
            // You can use constraints to adjust the layout for different screen sizes
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling, // Set a fixed text scale factor if necessary
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
