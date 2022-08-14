import 'package:flutter/cupertino.dart';
import 'build_animation.dart';

class AutoAnimationObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    StackNavigator.routeAnimation.add(AnimationRoute(animation: AutoAnimationController.animate, route: route));
    StackNavigator.route.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (StackNavigator.routeAnimation.last.route == route) {
      AutoAnimationController.animationIn(animation: StackNavigator.routeAnimation.last.animation);
    }
    StackNavigator.route.removeLast();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    StackNavigator.route.clear();
    StackNavigator.routeAnimation.last.animation.map((e) => e.dispose()).toList();
    StackNavigator.routeAnimation.removeLast();
    StackNavigator.route.add(route);
    super.didRemove(route, previousRoute);
  }
}

class AnimationRoute {
  Route route;
  List<AnimationController> animation;

  AnimationRoute({required this.animation, required this.route});
}

class StackNavigator {
  static List<AnimationRoute> routeAnimation = [];
  static List<Route> route = [];
}

class AutoAnimationController {
  static List<AnimationController> animate = [];

  static animationIn({List<AnimationController>? animation}) {
    for (var i in animation ?? animate) {
      i.forward();
    }
    if (animation != null) {
      StackNavigator.routeAnimation.removeLast();
    }
  }

  static animationOut({List<AnimationController>? animation}) {
    for (var i in animation ?? animate) {
      i.reverse();
    }
  }
}

mixin AutoAnimation<T extends StatefulWidget> on State<T> {
  Duration delayedAnimation = const Duration(milliseconds: 100);

  Widget autoAnimateParent({required Widget child}) {
    return WillPopScope(
      onWillPop: () async {
        AutoAnimationController.animationOut(animation: StackNavigator.routeAnimation.last.animation);
        await Future.delayed(Duration(milliseconds: 100 + delayedAnimation.inMilliseconds), () {});
        return true;
      },
      child: child,
    );
  }

  Widget autoAnimate({required Widget child, bool? isTop}) {
    return AutoFade(
      child: child,
      isTop: isTop ?? true,
    );
  }

  to(route) {
    AutoAnimationController.animationOut();
    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.push(context, route);
    });
  }

  @override
  void setState(VoidCallback fn) {
    AutoAnimationController.animate.clear();
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(delayedAnimation, () {
      AutoAnimationController.animationIn();
    });
  }
}
