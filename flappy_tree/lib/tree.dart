import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:moonlander/main.dart';

enum TreeState {
  down,
  up,
}

class Tree extends SpriteComponent with HasGameRef<TreeGame> {
  Tree({position, size});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('player-sprite.png');
  }

  void jump(Vector2 delta) {
    position.add(delta);
  }
}
