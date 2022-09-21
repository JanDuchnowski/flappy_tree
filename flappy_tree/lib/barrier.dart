import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/redux/game_state.dart';

class Barrier extends PositionComponent
    with HasGameRef<TreeGame>, CollisionCallbacks {
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;

  Barrier(Vector2 position, Vector2 size)
      : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.fill;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!GameState().wasHit && GameState().hasGameStarted) {
      if (position.x < -50) {
        position = Vector2(gameRef.size.x + 50, position.y);
      } else {
        position = Vector2(position.x - 1, position.y);
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    GameState().wasHit = true;
  }
}
