import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale;

  LocaleProvider(this._locale);

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    await PreferenceService.saveLanguage(locale.languageCode);
    notifyListeners();
  }
}