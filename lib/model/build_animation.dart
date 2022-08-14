import 'package:flutter/material.dart';

import 'auto_animation.dart';

class AutoFade extends StatefulWidget {
  final bool isTop;
  final Widget child;
  const AutoFade({Key? key, required this.child, this.isTop = true}) : super(key: key);

  @override
  State<AutoFade> createState() => AutoFadeState();
}

class AutoFadeState extends State<AutoFade> with TickerProviderStateMixin {
  Tween<double> alphaTween = Tween(begin: 0.0, end: 1.0);

  late Animation<Offset> position;
  late Animation<double> opacity;
  late AnimationController controller;

  setAnimation() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400), reverseDuration: const Duration(milliseconds: 400));
    position = Tween<Offset>(
      begin: Offset(0, widget.isTop ? -1.0 : 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    opacity = alphaTween.animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }

  @override
  void initState() {
    super.initState();
    setAnimation();
    AutoAnimationController.animate.add(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: FadeTransition(
        opacity: opacity,
        child: widget.child,
      ),
    );
  }
}
