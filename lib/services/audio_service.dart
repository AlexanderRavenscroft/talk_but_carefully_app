import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(String filePath) async {
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

