import 'package:flutter/material.dart';
import 'package:ui_test/model/auto_animation.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => Page3State();
}

class Page3State extends State<Page3> with AutoAnimation {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: autoAnimateParent(
        child: Center(
          child: autoAnimate(child: const Text('page 3')),
        ),
      ),
    );
  }
}
