import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:moonlander/main.dart';
import 'package:moonlander/tree.dart';

class Barrier extends PositionComponent
    with HasGameRef<TreeGame>, CollisionCallbacks {
  //late Vector2 velocity;
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;

  Barrier(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(100),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    final center = gameRef.size / 2;
    //  velocity = (center - position)..scaleTo(150);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // position.add(velocity * dt);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      removeFromParent();
      return;
    }
  }
}
