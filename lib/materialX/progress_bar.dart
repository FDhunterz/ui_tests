import 'package:flutter/material.dart';

class MateialXLinearProgrss extends StatelessWidget {
  final double progress;
  final Color color;
  final double height;
  const MateialXLinearProgrss({Key? key, required this.progress, required this.height, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height + 6 + 30,
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: progress.round(),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 36.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: height + 8,
                            width: 2,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 100 - progress.round(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 42.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: progress.round() < 50 ? progress.round() + 12 : progress.round(),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SizedBox(
                          height: height + 6 + 30,
                        ),
                        Positioned(
                          top: 0,
                          child: Transform.translate(
                            offset: Offset(
                                progress > 80
                                    ? 0
                                    : progress < 50
                                        ? 0
                                        : 25,
                                0),
                            child: Container(
                              height: 22,
                              width: 50,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  progress.toStringAsFixed(0),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 100 - progress.round(),
                    child: const SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
