import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/obstacles/barrier.dart';
import 'package:flutter_application_1/game.dart';

import 'package:flutter_application_1/redux/game_state.dart';

class Obstacles extends PositionComponent
    with HasGameRef<TreeGame>, CollisionCallbacks {
  late Barrier topBarrier;
  late Barrier bottomBarrier;
  final double topSize = 500;
  final double bottomSize = 500;
  late double topBarrierPosition;
  late double bottomBarrierPosition;

  Obstacles()
      : super(
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    _setBarrierPosition();
    topBarrier = Barrier(Vector2(gameRef.size.x - 50, topBarrierPosition),
        Vector2.array([52, topSize]))
      ..angle = radians(180);
    bottomBarrier = Barrier(Vector2(gameRef.size.x - 50, bottomBarrierPosition),
        Vector2.array([52, bottomSize]));
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
        restartBarrierPosition();
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

  void restartBarrierPosition() {
    _setBarrierPosition();
    topBarrier.position = Vector2(gameRef.size.x + 50, topBarrierPosition);
    topBarrier.size = Vector2.array([52, topSize]);
    bottomBarrier.position =
        Vector2(gameRef.size.x + 50, bottomBarrierPosition);
    bottomBarrier.size = Vector2.array([52, bottomSize]);
  }

  void _setBarrierPosition() {
    topBarrierPosition = (Random().nextDouble()) * 250;
    bottomBarrierPosition = topBarrierPosition + 700;
  }
}
