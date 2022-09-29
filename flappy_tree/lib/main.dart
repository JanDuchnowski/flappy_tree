import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/sounds.dart';

import 'package:flutter_application_1/views/menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'bg/lose-splash.png',
  ]);
  Sounds.initialize();
  runApp(Menu());
}
