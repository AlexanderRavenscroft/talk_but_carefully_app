import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/app_info.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'core/providers/ui_providers.dart'; 
import 'services/preference_service.dart';
import 'package:gadajaleostroznie/core/text_and_encounter.dart';
import 'package:gadajaleostroznie/core/providers/timer_provider.dart';
import 'package:gadajaleostroznie/presentation/screens/menu/menu_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); 
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load preferences and app version concurrently
  await Future.wait([
    PreferenceService.loadPreferences(),
    AppSetup.getAppVersion(),               
  ]);

  // Load locale prefrences
  String languageCode = await PreferenceService.loadLocalePreference();
  Locale initialLocale = Locale(languageCode);

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load all text files concurrently using Future.wait
  await Future.wait(textFiles.keys.map((path) => loadTextFiles()));
  await loadEncounterMessages();

  // Once everything is done, run the app
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ToggleProvider()),
          ChangeNotifierProvider(create: (context) => RefreshProvider()),
          ChangeNotifierProvider(create: (context) => GameToggleProvider()),
          ChangeNotifierProvider(create: (context) => GamePauseProvider()),
          ChangeNotifierProvider(create: (context) => TimerProvider()),
          ChangeNotifierProvider(
            create: (context) => LocaleProvider(initialLocale)),
        ],
        child: MyApp(), 
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Pass the navigation key to the app
      navigatorKey: NavigationService.navigatorKey,
    
      // Setup languages
      supportedLocales: L10n.all,
      locale: Provider.of<LocaleProvider>(context, listen: true).locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: 'Talk, but Carefully',
      home: MenuScreen(),
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
