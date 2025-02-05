// Global provider to refresh: team_settings_screen and game_screen
import 'package:flutter/material.dart';

///  Refresh WHOLE team_settings_screen when switch is toggled
class ToggleProvider extends ChangeNotifier {
  bool _isToggled = false;

  bool get isToggled => _isToggled;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners(); 
  }
}

/// Refresh team_settings_screen when color is choosen
class RefreshProvider extends ChangeNotifier {
  void refreshPage() {
    notifyListeners(); // Notify widgets that the page needs to rebuild
  }
}

/// Refresh game screen
class GameToggleProvider extends ChangeNotifier {
  void toggleTurns() {
    notifyListeners();
  }
}

class GamePauseProvider extends ChangeNotifier {
  bool _isPaused = false;

  bool get isPaused => _isPaused;

  void pauseGame() {
    _isPaused = !_isPaused;
    notifyListeners(); 
  }
}