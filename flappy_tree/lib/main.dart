import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:moonlander/barrier.dart';
import 'package:moonlander/tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final game = TreeGame();

  runApp(GameWidget(game: game));
}

/// This class encapulates the whole game.
class TreeGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Tree tree;
  late Barrier topBarrier;
  late Barrier bottomBarrier;
  @override
  Future<void> onLoad() async {
    tree = Tree()
      ..position = size / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;
    add(tree);
    topBarrier = Barrier(Vector2(size.x - 100, 100));
    bottomBarrier = Barrier(Vector2(size.x - 100, size.y - 100));
    add(topBarrier);
    add(bottomBarrier);
    return null;
  }

  @override
  void onTap() {
    tree.jump(Vector2(0, -20));
  }

  @override
  void update(dt) {
    super.update(dt);
    tree.position = Vector2(tree.position.x + 1, tree.position.y + 1);
  }
}
