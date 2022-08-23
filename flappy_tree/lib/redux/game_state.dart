class GameState {
  static final GameState _singleton = GameState._internal();
  bool wasHit = false;
  bool hasGameStarted = false;
  factory GameState() {
    return _singleton;
  }

  GameState._internal();
}
