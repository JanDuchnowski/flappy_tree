import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:moonlander/main.dart';
import 'package:moonlander/redux/game_state.dart';

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
    FlameAudio.play('tree_jump.wav', volume: 1);
    if (!GameState().wasHit) {
      position.add(Vector2(0, -30));
    }
  }

  @override
  void update(double dt) {
    if (!GameState().wasHit && GameState().hasGameStarted) {
      position = Vector2(position.x, position.y + 1.35);
      super.update(dt);
    }
  }
}
