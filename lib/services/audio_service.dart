// Audio manager for whole app. Edit the actual sounds in core/globals.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:gadajaleostroznie/core/globals.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Duration _spamPreventionDelay = Duration(milliseconds: 200); // Adjust the delay duration here
  DateTime? _lastPlayTime; // Tracks the last play time

  // Centralized method to play audio only if soundToggled is true
  Future<void> playSound(String filePath) async {
    if (!soundToggled) {
      debugPrint('Sound is toggled off, not playing: $filePath');
      return; // Return early if sound is off
    }

    // Prevent spam by checking the delay
    final now = DateTime.now();
    if (_lastPlayTime != null &&
        now.difference(_lastPlayTime!) < _spamPreventionDelay) {
      debugPrint('Spam prevention: too soon to play sound: $filePath');
      return;
    }

    _lastPlayTime = now; // Update last play time

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint('Attempting to play: $filePath');
      await _audioPlayer.setReleaseMode(ReleaseMode.stop); // Ensure playback stops after sound ends
      await _audioPlayer.play(AssetSource(filePath)).catchError((e) {
        debugPrint('Error playing sound: $e');
      });
    });
  }
}

final AudioService audioService = AudioService();

// Simplified function to play any sound based on passed argument
Future<void> playAudio(String sound) async {
  await audioService.playSound(sound);
}
