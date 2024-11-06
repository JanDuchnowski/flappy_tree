import 'dart:async';

import 'package:flame/flame.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/sounds.dart';

import 'package:flutter_application_1/views/menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.images.loadAll(<String>[
    'mecha-biom-barrier.png',
    'mecha-biom-barrier2.png',
    'pipe-green.png'
  ]);
  Sounds.initialize();
  runApp(Menu());
}
