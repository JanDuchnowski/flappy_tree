import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:moonlander/main.dart';
import 'package:moonlander/tree.dart';

class Barrier extends PositionComponent
    with HasGameRef<TreeGame>, CollisionCallbacks {
  final _defaultColor = Colors.cyan;
  final Vector2 _viewPortSize;
  late ShapeHitbox hitbox;

  Barrier(Vector2 position, Vector2 size, Vector2 this._viewPortSize)
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
    if (!wasHit) {
      if (position.x < -50) {
        position = Vector2(size.x + 350, position.y);
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
    wasHit = true;
    if (other is ScreenHitbox) {
      removeFromParent();
      return;
    }
  }
}
