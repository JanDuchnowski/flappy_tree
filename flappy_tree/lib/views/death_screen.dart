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

class DeathView extends SpriteComponent with HasGameRef<TreeGame> {
  late Rect titleRect;
  Sprite? titleSprite;
  late Image image;

  DeathView() {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('bg/lose-splash.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite!.renderRect(
        canvas, Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y));
  }
}
