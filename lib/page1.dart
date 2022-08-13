import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_test/page2.dart';
import 'package:ui_test/router_animation.dart';

import 'model/card_model.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<String> region = ['Ini', 'Indonesia', 'Singapore', 'Japan', 'Indonesia1', 'Singapore1', 'Japan1', 'Indonesia2', 'Singapore2', 'Japan2'];
  String selectedRegion = "Indonesia";
  List<CardModel> cardList = [
    CardModel(category: 'Panorama', title: 'Indonesia', image: 'https://images.pexels.com/photos/758742/pexels-photo-758742.jpeg?cs=srgb&dl=pexels-ahmad-syahrir-758742.jpg&fm=jpg'),
    CardModel(category: 'Panorama', title: 'Bali', image: 'https://c4.wallpaperflare.com/wallpaper/179/915/685/photography-water-reflection-bali-wallpaper-preview.jpg'),
    CardModel(category: 'Panorama', title: 'Bromo', image: 'https://images.unsplash.com/photo-1602154663343-89fe0bf541ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bW91bnQlMjBicm9tb3xlbnwwfHwwfHw%3D&w=1000&q=80'),
  ];
  final pc = PageController(
    initialPage: (99999 / 2).floor(),
    viewportFraction: 0.5,
  );
  int indexActive = (99999 / 2).floor() % 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: Colors.black.withOpacity(.05),
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.menu,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Discover',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                        Material(
                          color: Colors.black.withOpacity(.05),
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.search,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: region.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final d = region[index];
                        return InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              selectedRegion = d;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.0, right: index == region.length - 1 ? 18 : 0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 70,
                                minWidth: 0,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                      color: selectedRegion == d ? const Color(0xff67bfb2) : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    d,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: selectedRegion == d ? const Color(0xff67bfb2) : Colors.black38),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: PageView.builder(
                      controller: pc,
                      itemCount: 99999,
                      onPageChanged: (i) {
                        indexActive = i % 3;
                        setState(() {});
                      },
                      itemBuilder: (context, i) {
                        final getIndex = i % 3;
                        final datas = cardList[getIndex];

                        return AnimatedScale(
                          scale: getIndex == indexActive ? 1 : 0.8,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0, top: 12),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.white, boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(.05), offset: const Offset(0, 2), blurRadius: 10),
                              ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Hero(
                                        tag: 'images_$i',
                                        transitionOnUserGestures: true,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, fadeIn(page: Page2(hero: 'images_$i')));
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              width: double.infinity,
                                              height: 170,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 8),
                                                  ),
                                                ],
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                image: DecorationImage(
                                                  image: NetworkImage(datas.image),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 20,
                                        top: 20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.white30,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.white12,
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.white30,
                                                ),
                                              ),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                                                child: const Text(
                                                  '4,7',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                datas.title,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Colors.black.withOpacity(
                                                    0.6,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.settings,
                                                size: 18,
                                                color: Colors.black.withOpacity(
                                                  0.6,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            datas.category,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Destination',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(.6), fontSize: 18),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xff67bfb2), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final size = (MediaQuery.of(context).size.width * .5) - 12;
                        final List<Widget> widgetStack = [];

                        widgetStack.add(card(size));
                        widgetStack.add(card(size));
                        return Padding(
                          padding: EdgeInsets.only(bottom: index == 3 ? 80 : 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widgetStack.toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                width: MediaQuery.of(context).size.width - 24,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xff67bfb2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.home, color: Colors.white),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.compass_calibration, color: Colors.white),
                          SizedBox(
                            width: 5,
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.star, color: Colors.white),
                          SizedBox(
                            width: 5,
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.supervised_user_circle, color: Colors.white),
                          SizedBox(
                            width: 5,
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget card(size) {
  return SizedBox(
    width: size,
    child: Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/758742/pexels-photo-758742.jpeg?cs=srgb&dl=pexels-ahmad-syahrir-758742.jpg&fm=jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Indonesia',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                  Text(
                    'Hotels',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
