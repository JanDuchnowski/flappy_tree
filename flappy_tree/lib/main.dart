import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 400);

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

double treePosition() {
  return Random().nextDouble() * 10;
}

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  late Color color;
  late double borderRadius;
  late double margin;
  late double position;
  bool up = false;

  @override
  initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
    position = treePosition();
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
      position = treePosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 88,
              height: 88,
              child: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    up = false;
                  });
                },
                padding: EdgeInsets.all(10.0),
                duration: Duration(milliseconds: 250), // Animation speed
                transform: Transform.translate(
                  offset: Offset(
                      0, up == true ? -100 : 0), // Change -100 for the y offset
                ).transform,
                child: Container(
                  height: 50.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.ac_unit),
                    onPressed: () {
                      setState(() {
                        up = !up;
                      });
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('change'),
              onPressed: () => change(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedContainerDemo(),
    );
  }
}

void main() {
  runApp(
    const MyApp(),
  );
}
