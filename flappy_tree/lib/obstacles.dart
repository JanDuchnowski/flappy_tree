import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_application_1/barrier.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/redux/game_state.dart';

class Obstacles extends PositionComponent
    with HasGameRef<TreeGame>, CollisionCallbacks {
  late Barrier topBarrier;
  late Barrier bottomBarrier;
  late double topSize;
  late double bottomSize;

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
    if (GameState().hasGameStarted) {
      if (topBarrier.position.x < -47) {
        setBarrierSize();
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

  void setBarrierSize() {
    topSize = (Random().nextDouble()) * (gameRef.size.y / 2) - 100;
    bottomSize = gameRef.size.y - topSize - 250;
    print("topSize ${topSize}");
  }

  void setInitialBarrierPosition() {
    setBarrierSize();
    topBarrier = Barrier(Vector2(gameRef.size.x - 50, topSize / 2),
        Vector2.array([100, topSize]));
    bottomBarrier = Barrier(
        Vector2(gameRef.size.x - 50, gameRef.size.y - bottomSize / 2),
        Vector2.array([100, bottomSize]));
  }

  void restartBarrierPosition() {
    setBarrierSize();
    topBarrier.position = Vector2(gameRef.size.x - 50, topSize / 2);
    topBarrier.size = Vector2.array([100, topSize]);
    bottomBarrier.position =
        Vector2(gameRef.size.x - 50, gameRef.size.y - bottomSize / 2);
    bottomBarrier.size = Vector2.array([100, bottomSize]);
  }
}
