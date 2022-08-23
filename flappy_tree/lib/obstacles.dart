import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:moonlander/barrier.dart';
import 'package:moonlander/main.dart';

import 'views/death_screen.dart';

class Obstacles extends PositionComponent
    with HasGameRef<TreeGame>, CollisionCallbacks {
  late Barrier topBarrier;
  late Barrier bottomBarrier;
  bool isGameActive = false;

  Obstacles()
      : super(
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    setInitialBarrierPosition();
  }

  @override
  void onMount() {
    add(bottomBarrier);
    add(topBarrier);
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.gameStarted) {
      if (topBarrier.position.x < -50) {
        double topSize = (Random().nextDouble()) * (size.y / 2);
        double bottomSize = size.y - topSize - 250;
        topBarrier.size = Vector2.array([
          100,
          topSize,
        ]);
        bottomBarrier.size = Vector2.array([100, bottomSize]);
      }
      double relativePostion = gameRef.tree.position.x - topBarrier.position.x;
      if (relativePostion <= 1 && relativePostion >= -1) {
        gameRef.score++;
        gameRef.scoreText.text = "${gameRef.score}";
      }
      topBarrier.update(dt);
      bottomBarrier.update(dt);
    }
  }

  void setInitialBarrierPosition() {
    double topSize = (Random().nextDouble()) * (gameRef.size.y / 2);
    double bottomSize = gameRef.size.y - topSize - 250;
    topBarrier = Barrier(Vector2(gameRef.size.x - 50, topSize / 2),
        Vector2.array([100, topSize]), isGameActive);
    bottomBarrier = Barrier(
        Vector2(gameRef.size.x - 50, gameRef.size.y - bottomSize / 2),
        Vector2.array([100, bottomSize]),
        isGameActive);
  }

  void restartBarrierPosition() {
    gameRef.score = 0;
    gameRef.scoreText.text = "${gameRef.score}";
    double topSize = (Random().nextDouble()) * (gameRef.size.y / 2);
    double bottomSize = gameRef.size.y - topSize - 250;
    topBarrier.position = Vector2(gameRef.size.x - 50, topSize / 2);
    bottomBarrier.position =
        Vector2(gameRef.size.x - 50, gameRef.size.y - bottomSize / 2);
  }
}
