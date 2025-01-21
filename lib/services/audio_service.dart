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

// Simplified functions without repeating the sound toggle check
Future<void> playTapAudio() async {
  await audioService.playSound('sounds/button-press.mp3');
}

Future<void> playOptionChoiceAudio() async {
  await audioService.playSound('sounds/option-choice.mp3');
}

Future<void> playCorrectAnswerAudio() async {
  await audioService.playSound('sounds/correct-answer.mp3');
}

Future<void> playWrongAnswerAudio() async {
  await audioService.playSound('sounds/wrong-answer.mp3');
}
