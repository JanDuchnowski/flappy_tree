import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';

class GameState {
  static final GameState _singleton = GameState._internal();
  bool wasHit = false;
  bool hasGameStarted = false;
  final AudioPlayer player = AudioPlayer();

  factory GameState() {
    return _singleton;
  }

  GameState._internal();
}
