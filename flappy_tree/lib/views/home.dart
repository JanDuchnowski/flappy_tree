import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:moonlander/main.dart';

class HomeView extends SpriteComponent with HasGameRef<TreeGame> {
  late Rect titleRect;
  Sprite? titleSprite;
  late Image image;

  HomeView() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('bg/backyard.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite!.renderRect(
        canvas, Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y));
  }
}
