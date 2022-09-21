import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class HomeView extends SpriteComponent with HasGameRef<TreeGame> {
  late Rect titleRect;
  Sprite? titleSprite;
  late Image image;

  HomeView() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.play('start-menu.wav');
    sprite = await gameRef.loadSprite('bg/backyard.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite!.renderRect(
        canvas, Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y));
  }
}
