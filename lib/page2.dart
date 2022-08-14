import 'package:flutter/material.dart';
import 'package:ui_test/model/auto_animation.dart';
import 'package:ui_test/page3.dart';
import 'package:ui_test/router_animation.dart';

class Page2 extends StatefulWidget {
  final String hero;
  const Page2({Key? key, required this.hero}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with TickerProviderStateMixin, AutoAnimation {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: autoAnimateParent(
        child: InkWell(
          onTap: () {
            to(fadeIn(page: const Page3()));
          },
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: autoAnimate(
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 8),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1542351567-cd7b06dc08d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
