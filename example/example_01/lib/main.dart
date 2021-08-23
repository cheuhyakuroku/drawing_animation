import 'package:flutter/material.dart';
import 'dart:math';
import 'package:drawing_animation/drawing_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool run = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
                run = !run;
              }),
          child: Icon((run) ? Icons.stop : Icons.play_arrow)),
      body: Center(
          child: Column(children: <Widget>[
        //Simplfied AnimatedDrawing using Flutter Path objects
        Expanded(
            child: AnimatedDrawing.paths(
          [
            (Path()
                  ..addOval(Rect.fromCircle(center: Offset.zero, radius: 75.0)))
                .transform(Matrix4.rotationX(-pi)
                    .storage), //A circle which is slightly rotated
          ],
          paints: [
            Paint()..style = PaintingStyle.stroke,
          ],
          run: run,
          animationOrder: PathOrders.original,
          duration: const Duration(seconds: 2),
          lineAnimation: LineAnimation.oneByOne,
          animationCurve: Curves.linear,
          onFinish: () => setState(() {
            run = false;
          }),
        )),

        //Simplfied AnimatedDrawing parsing Path objects from an Svg asset
        Expanded(
            child: AnimatedDrawing.svg(
          "assets/circle.svg",
          run: run,
          duration: const Duration(seconds: 2),
          lineAnimation: LineAnimation.oneByOne,
          animationCurve: Curves.linear,
          onFinish: () => setState(() {
            run = false;
          }),
        )),
      ])),
    );
  }
}
