import 'dart:async';
import 'dart:math';

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
    double topSize = (Random().nextDouble()) * (size.y / 2);
    double bottomSize = size.y - topSize - 250;
    print(topSize);
    print(bottomSize);
    topBarrier = Barrier(Vector2(size.x - 100, topSize / 2),
        Vector2.array([100, topSize]), size);

    bottomBarrier = Barrier(Vector2(size.x - 100, size.y - bottomSize / 2),
        Vector2.array([100, bottomSize]), size);
    add(topBarrier);
    add(bottomBarrier);
    return null;
  }

  @override
  void onTap() {
    tree.jump();
  }

  @override
  void update(dt) {
    super.update(dt);
    tree.update(dt);
    if (topBarrier.position.x < -50) {
      double topSize = (Random().nextDouble()) * (size.y / 2);
      double bottomSize = size.y - topSize - 250;
      topBarrier.size = Vector2.array([
        100,
        topSize,
      ]);
      bottomBarrier.size = Vector2.array([100, bottomSize]);
    }
    topBarrier.update(dt);
    bottomBarrier.update(dt);
  }
}
