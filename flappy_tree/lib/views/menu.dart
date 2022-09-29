import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/game.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.play('start-menu.wav');
    return MaterialApp(
      home: Scaffold(
        body: MyGame(),
      ),
    );
  }
}
