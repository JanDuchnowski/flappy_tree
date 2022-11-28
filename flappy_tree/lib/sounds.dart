import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache
        .loadAll(['tree-jump.wav', 'start-menu.wav', 'music-beginning.wav']);
  }

  static void menuTheme() {
    FlameAudio.bgm.play('start_menu.wav');
  }

  static void gameplayTheme() {
    FlameAudio.bgm.play('music-beginning.wav');
  }

  static void jumpSound() {
    AudioPlayer player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.release);
    player.play(
      AssetSource('audio/tree-jump.wav'),
    );
  }

  static void pauseBackgroundSound() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    FlameAudio.bgm.dispose();
  }
}
