import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:gadajaleostroznie/logic/globals.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();


  // Centralized method to play audio only if soundToggled is true
  Future<void> playSound(String filePath) async {
    if (!soundToggled) {
      debugPrint('Sound is toggled off, not playing: $filePath');
      return; // Return early if sound is off
    }

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