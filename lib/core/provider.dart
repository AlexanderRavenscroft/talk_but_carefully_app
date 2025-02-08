// Global provider to refresh: team_settings_screen and game_screen
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'dart:async';
import 'package:provider/provider.dart';
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
    notifyListeners(); 
  }
}

/// Refresh game screen
class GameToggleProvider extends ChangeNotifier {
  void toggleTurns() {
    notifyListeners();
  }
}

/// Update screen after game pause occurs
class GamePauseProvider extends ChangeNotifier {
  bool _isPaused = false;

  bool get isPaused => _isPaused;

  void pauseGame() {
    _isPaused = !_isPaused;
    notifyListeners(); 
  }
}


class TimerProvider extends ChangeNotifier {

  int _timeLeft = GameSettings.aviableTime;

  Timer? _timer; 
  int get timeLeft => _timeLeft;


  void setTimeLeft(int newTime) {
    _timeLeft = newTime;
    notifyListeners();
  }

  void startTimer() {
   // stopTimer();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
      } 
      else {
        timer.cancel();
        _timer = null; // Clear timer reference

        // Ensure context is valid before accessing it
        if (navigatorKey.currentContext != null) {
          final gameToggleProvider = Provider.of<GameToggleProvider>(
            navigatorKey.currentContext!,
            listen: false,
          );
          gameToggleProvider.toggleTurns();
        }
        if(!teams.any((team) => team.points >= GameSettings.aviablePoints)) {
          playAudio(GameSounds.roundOver);
        }
        nextScreen();
      }

      if (hasListeners) {
        notifyListeners();
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if(reset) {
      resetTimer();
    }
    _timer?.cancel();
  }

  void resetTimer() {
    _timeLeft = GameSettings.aviableTime;
  }
}
