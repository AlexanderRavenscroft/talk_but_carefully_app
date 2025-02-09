// Global provider to refresh game_screen and manage timer.
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/core/providers/ui_providers.dart';

//====================[TIMER PROVIDER]====================
class TimerProvider extends ChangeNotifier {
  int _timeLeft = GameSettings.aviableTime; 
  Timer? _timer; 

  // Getter for time left
  int get timeLeft => _timeLeft;

  void setTimeLeft(int newTime) {
    _timeLeft = newTime;
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) { // Each tick
        _timeLeft--; 
      } else { // Timer runs out
        timer.cancel(); 
        _timer = null; 

        // Ensure context is valid before accessing it
        if (NavigationService.navigatorKey.currentContext != null) {
          final gameToggleProvider = Provider.of<GameToggleProvider>(
            NavigationService.navigatorKey.currentContext!,
            listen: false,
          );
          gameToggleProvider.toggleTurns(); // Toggle turns when time runs out
        }

        if (!teams.any((team) => team.points >= GameSettings.aviablePoints)) {
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
    if (reset) {
      resetTimer(); 
    }
    _timer?.cancel(); 
  }

  void resetTimer() {
    _timeLeft = GameSettings.aviableTime;
  }
}
//====================[/TIMER PROVIDER]====================