import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GetCarouselSlider extends StatelessWidget {
  GetCarouselSlider({Key? key}) : super(key: key);

  List<String> homePageBackgroundListForCarouselSlider = [
    'lib/assets/homepage/background_one.png',
    'lib/assets/homepage/background_two.png',
    'lib/assets/homepage/background_three.png',
    'lib/assets/homepage/background_four.png',
    'lib/assets/homepage/background_five.png',
    'lib/assets/homepage/background_six.png',
  ];

  @override
  Widget build(BuildContext context) {
    homePageBackgroundListForCarouselSlider.shuffle();
    return CarouselSlider.builder(
      itemCount: homePageBackgroundListForCarouselSlider.length,
      itemBuilder: (context, index, pageViewIndex) {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            homePageBackgroundListForCarouselSlider[index],
            fit: BoxFit.fitWidth,
            // alignment: Alignment.topLeft,
            alignment: Alignment.center,
          ),
        );
      },
      options: CarouselOptions(
        aspectRatio: 9 / 16,
        viewportFraction: .8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
