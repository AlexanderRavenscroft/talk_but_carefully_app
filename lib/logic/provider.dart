import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/logic/globals.dart';

class ToggleProvider extends ChangeNotifier {
  bool _isToggled = false;

  bool get isToggled => _isToggled;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}

class RefreshProvider extends ChangeNotifier {
  void refreshPage() {
    notifyListeners(); // Notify widgets that the page needs to rebuild
  }
}

class GameToggleProvider extends ChangeNotifier {
  bool _isTeamBluePlaying = false;

bool get isTeamBluePlaying => _isTeamBluePlaying;

  void toggleTurns() {
    _isTeamBluePlaying = !_isTeamBluePlaying;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}