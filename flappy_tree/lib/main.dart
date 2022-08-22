import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:moonlander/barrier.dart';
import 'package:moonlander/score.dart';
import 'package:moonlander/tree.dart';
import 'package:moonlander/views/death_screen.dart';
import 'package:moonlander/views/home.dart';

bool wasHit = false;
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

  final game = TreeGame();

  runApp(GameWidget(game: TreeGame()));
}

// class StartingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Scaffold(
//       body:
//       InkWell(child: Container(width: 50, ),
//       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Tree)))),
//     ));
//   }
// }

/// This class encapulates the whole game.
class TreeGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Tree tree;
  late Barrier topBarrier;
  late Barrier bottomBarrier;
  late TextComponent scoreText;
  late HomeView homeView;
  bool gameStarted = false;

  int score = 0;
  @override
  Future<void> onLoad() async {
    tree = Tree()
      ..position = size / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;
    add(tree);

    double topSize = (Random().nextDouble()) * (size.y / 2);
    double bottomSize = size.y - topSize - 250;
    print(topSize);
    print(bottomSize);
    topBarrier = Barrier(
        Vector2(size.x - 50, topSize / 2), Vector2.array([100, topSize]), size);

    bottomBarrier = Barrier(Vector2(size.x - 50, size.y - bottomSize / 2),
        Vector2.array([100, bottomSize]), size);
    add(topBarrier);
    add(bottomBarrier);
    scoreText = TextComponent(text: "0", position: Vector2(size.x / 2, 100));
    add(scoreText);
    homeView = HomeView();
    add(homeView);
    return null;
  }

  @override
  void onTap() {
    if (!gameStarted) {
      gameStarted = true;
      remove(homeView);
    }
    tree.jump();
  }

  @override
  void update(dt) {
    super.update(dt);
    if (gameStarted) {
      if (topBarrier.position.x < -50) {
        double topSize = (Random().nextDouble()) * (size.y / 2);
        double bottomSize = size.y - topSize - 250;
        topBarrier.size = Vector2.array([
          100,
          topSize,
        ]);
        bottomBarrier.size = Vector2.array([100, bottomSize]);
      }
      double relativePostion = tree.position.x - topBarrier.position.x;
      if (relativePostion <= 1 && relativePostion >= -1) {
        score++;
        scoreText.text = "${score}";
      }
      topBarrier.update(dt);
      bottomBarrier.update(dt);
      if (wasHit) {
        add(DeathView());
        gameStarted = false;
      }
    }
  }
}
