import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:moonlander/barrier.dart';
import 'package:moonlander/main.dart';

class HomeView extends SpriteComponent with Tappable, HasGameRef<TreeGame> {
  late Rect titleRect;
  Sprite? titleSprite;
  late Image image;
  late Barrier topBarrier;
  late Barrier bottomBarrier;
  late TextComponent scoreText;
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

  @override
  bool onTapDown(TapDownInfo info) {
    print("tapped");
    double topSize = (Random().nextDouble()) * (size.y / 2);
    double bottomSize = size.y - topSize - 250;
    print(topSize);
    print(bottomSize);
    topBarrier = Barrier(
        Vector2(size.x - 50, topSize / 2), Vector2.array([100, topSize]), size);

    bottomBarrier = Barrier(Vector2(size.x - 50, size.y - bottomSize / 2),
        Vector2.array([100, bottomSize]), size);
    add(topBarrier);
    add(bottomBarrier);
    scoreText = TextComponent(text: "0", position: Vector2(size.x / 2, 100));
    add(scoreText);
    return super.onTapDown(info);
  }
}
