import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';

class GameState {
  static final GameState _singleton = GameState._internal();
  bool wasHit = false;
  bool hasGameStarted = false;
  final AudioPlayer player = AudioPlayer();

  Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(['tree_jump.wav', 'start-menu.wav']);
  }

  // Starts the given audio file as BGM on loop.
  void startBgm(String fileName) {
    FlameAudio.bgm.play(fileName, volume: 0.4);
  }

  // Pauses currently playing BGM if any.
  void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  // Resumes currently paused BGM if any.
  void resumeBgm() {
    FlameAudio.bgm.resume();
  }

  // Stops currently playing BGM if any.
  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  // Plays the given audio file once.
  void playSfx(String filename) {
    FlameAudio.play(filename);
  }

  factory GameState() {
    return _singleton;
  }

  GameState._internal();
}
