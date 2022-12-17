import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/obstacles/obstacles.dart';
import 'package:flutter_application_1/sounds.dart';
import 'package:flutter_application_1/tree.dart';
import 'package:flutter_application_1/views/bg_image.dart';
import 'package:flutter_application_1/views/death_screen.dart';
import 'package:flutter_application_1/views/menu.dart';

import 'game_state.dart';

class MyGame extends StatelessWidget {
  MyGame();
  void _startGame() {
    Sounds.pauseBackgroundSound();
    GameState().hasGameStarted = true;
    Sounds.gameplayTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: InkWell(
          child: Container(color: Colors.amber),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GameWidget(
                  game: TreeGame(),
                ),
              ),
            );
            _startGame();
          },
        ),
      ),
    );
  }
}

class TreeGame extends FlameGame with TapDetector, HasCollisionDetection {
  final DeathView deathView = DeathView();
  final BackgroundImage backgroundImage = BackgroundImage();
  late Tree tree;
  late TextComponent scoreText;
  late Menu menu;
  late Obstacles obstacles;

  bool deathScreenAdded = false;
  int score = 0;

  @override
  Future<void> onLoad() async {
    add(backgroundImage);
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
    menu = Menu();
  }

  @override
  void onTap() {
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
