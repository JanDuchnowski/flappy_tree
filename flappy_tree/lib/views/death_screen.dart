import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/game.dart';
import 'package:flutter_application_1/main.dart';

class DeathView extends SpriteComponent with HasGameRef<TreeGame> {
  late Rect titleRect;
  Sprite? titleSprite;
  late Image image;

  DeathView() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('bg/bg-example.jpg');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite!.renderRect(
        canvas, Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y));
  }
}
