import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';

import 'package:moonlander/obstacles.dart';
import 'package:moonlander/redux/game_state.dart';
import 'package:moonlander/tree.dart';
import 'package:moonlander/views/death_screen.dart';
import 'package:moonlander/views/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'bg/lose-splash.png',
    'branding/title.png',
    'ui/callout.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/icon-music-disabled.png',
    'ui/icon-music-enabled.png',
    'ui/icon-sound-disabled.png',
    'ui/icon-sound-enabled.png',
    'ui/start-button.png',
  ]);

  runApp(GameWidget(game: TreeGame()));
}

class TreeGame extends FlameGame with TapDetector, HasCollisionDetection {
  final DeathView deathView = DeathView();
  late Tree tree;
  late TextComponent scoreText;
  late HomeView homeView;
  late Obstacles obstacles;

  bool deathScreenAdded = false;
  int score = 0;

  @override
  Future<void> onLoad() async {
    tree = Tree()
      ..position = size / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;
    add(tree);
    obstacles = Obstacles();
    add(obstacles);
    scoreText = TextComponent(text: "0", position: Vector2(size.x / 2, 100));
    add(scoreText);
    homeView = HomeView();
    add(homeView);
    return null;
  }

  @override
  void onTap() {
    if (!GameState().hasGameStarted) {
      _startGame();
    }
    if (GameState().wasHit) {
      _restartGame();
    }
    tree.jump();
  }

  @override
  void update(double dt) {
    if (GameState().wasHit && !deathScreenAdded) {
      add(deathView);
      deathScreenAdded = true;
    }
    super.update(dt);
  }

  void _startGame() {
    GameState().hasGameStarted = true;
    remove(homeView);
  }

  void _resetScore() {
    score = 0;
    scoreText.text = "${score}";
  }

  void _restartGame() {
    _resetScore();
    GameState().wasHit = false;
    if (deathView.isMounted == true) {
      remove(deathView);
      deathScreenAdded = false;
    }
    tree.position = size / 2;
    obstacles.restartBarrierPosition();
  }
}
