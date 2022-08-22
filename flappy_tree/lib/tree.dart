import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:moonlander/main.dart';

enum TreeState {
  down,
  up,
}

class Tree extends SpriteComponent
    with CollisionCallbacks, HasGameRef<TreeGame> {
  Tree({position, size});
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    hitbox = RectangleHitbox()..renderShape = false;

    add(hitbox);
    sprite = await gameRef.loadSprite('player-sprite.png');
  }

  void jump() {
    if (!wasHit) {
      position.add(Vector2(0, -30));
    }
  }

  @override
  void update(double dt) {
    if (!wasHit && gameRef.gameStarted) {
      position = Vector2(position.x, position.y + 1);
      super.update(dt);
    }
  }
}
