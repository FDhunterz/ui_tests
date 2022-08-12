import 'dart:async';

import 'package:flutter/material.dart';

class ScaleAnimations extends StatefulWidget {
  final Widget child;
  final Duration? delay;
  final double? begin;
  final double? end;
  final bool active;
  const ScaleAnimations({Key? key, required this.child, this.delay, required this.active, this.begin, this.end}) : super(key: key);

  @override
  State<ScaleAnimations> createState() => ScaleAnimationsState();
}

class ScaleAnimationsState extends State<ScaleAnimations> with TickerProviderStateMixin {
  Tween<double> tween = Tween(begin: 0.0, end: 1.0);
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    tween = Tween(begin: widget.begin ?? 0.0, end: widget.end ?? 1.0);
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400), reverseDuration: const Duration(milliseconds: 400));

    Future.delayed(widget.delay ?? Duration.zero, () {
      start();
    });
    if (widget.active) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  start() {
    controller.forward();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationsAnimation(
      animation: tween.animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      tween: tween,
      child: widget.child,
    );
  }
}

class ScaleAnimationsAnimation extends AnimatedWidget {
  const ScaleAnimationsAnimation({Key? key, required Animation<double> animation, required this.child, required this.tween}) : super(key: key, listenable: animation);
  final Tween<double> tween;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: animation.value,
      child: child,
    );
  }
}
