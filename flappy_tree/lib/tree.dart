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
    await FlameAudio.audioCache.loadAll(['tree_jump.wav', 'start-menu.wav']);
    hitbox = RectangleHitbox()..renderShape = false;

    add(hitbox);
    sprite = await gameRef.loadSprite('player-sprite.png');
  }

  void jump() {
    if (!GameState().wasHit) {
      FlameAudio.play('tree_jump.wav');
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
