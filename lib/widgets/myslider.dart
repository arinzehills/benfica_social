
import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MySlider extends StatefulWidget {
  const MySlider({super.key,this.imageUrls=const [
    "https://brainworldinc.com/mobileimages/labslide1.jpg",
    "https://brainworldinc.com/mobileimages/labslide2.jpg",
    "https://brainworldinc.com/mobileimages/labslide3.jpg"
  ]});
  final List<String> imageUrls;

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int activeIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width,
                 
      margin: EdgeInsets.all(5),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
          height: size(context).height * 0.5,

            child: CarouselSlider.builder(
              itemCount: widget.imageUrls.length ,
              carouselController: _carouselController,
              options: CarouselOptions(
                enlargeCenterPage: true,
                enlargeFactor: 0.22,
                viewportFraction: 1,
                // autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 60),
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                height: 600,
              ),
              itemBuilder: (ctx, index, realIndex) {
                return buildImage(widget.imageUrls[index], index);
              },
            ),
          ),
          // Constants.topMargin(15),
          Positioned.fill(
            child: Align(
               alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildIndicator(),
              )))
        ],
      ),
    );
  }

  Widget buildImage(url, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      height: 500,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
          url,
            width: 900,
            fit: BoxFit.cover,
          )
          // Image.asset(
          //   url,
          //   width: 900,
          //   fit: BoxFit.cover,
          // ),
          ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
            dotWidth: 12,
            dotHeight: 7,
            activeDotColor: Color.fromARGB(255, 255, 164, 115)),
        activeIndex: activeIndex,
        count: widget.imageUrls.length,
        onDotClicked: (index) {
          setState(() {
            activeIndex = index;
          });
          _carouselController.jumpToPage(index);
        },
      );
}
