import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_application_1/game.dart';
import 'package:flutter_application_1/game_state.dart';
import 'package:flutter_application_1/sounds.dart';

enum TreeState {
  down,
  up,
}

class Tree extends SpriteComponent
    with CollisionCallbacks, HasGameRef<TreeGame> {
  Tree({position, size});
  late ShapeHitbox hitbox;
  late List szyc;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    hitbox = RectangleHitbox()..renderShape = false;

    add(hitbox);
    sprite = await gameRef.loadSprite('player-sprite.png');
  }

  void jump() {
    if (!GameState().wasHit) {
      Sounds.jumpSound();
      position.add(Vector2(0, -30));
    }
  }

  @override
  void update(double dt) {
    if (!GameState().wasHit && GameState().hasGameStarted) {
      position = Vector2(position.x, position.y + 1.0);
      super.update(dt);
    }
  }
}
