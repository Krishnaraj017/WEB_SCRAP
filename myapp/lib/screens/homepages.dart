import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CarouselController _controller = CarouselController();

  final List<String> flipkartCarouselImageUrlList = [
    "https://rukminim1.flixcart.com/flap/700/300/image/b0e088ff138c58be.jpg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/aebf043a3a4f15d6.jpg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/c16af8723f41e655.jpeg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/a395b780f474838c.jpg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/714233634472f340.jpeg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/24d2d83a84eee76b.jpg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/b92081b232f55ec0.jpeg?q=90",
    "https://rukminim1.flixcart.com/flap/700/300/image/4786aae94e794340.jpg?q=90",
  ];

  int _current = 0;

  Widget _buildDotsLoader() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey.withOpacity(0.45),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: flipkartCarouselImageUrlList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: (_current == entry.key) ? 17.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: _current == entry.key
                      ? Colors.white.withOpacity(1.0)
                      : Colors.grey.withOpacity(0.9)),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: 700 / 300,
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CarouselSlider(
                            items: flipkartCarouselImageUrlList
                                .map((deal) => GestureDetector(
                                      onTap: () {
                                        // todo -> navigate to someplace
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: deal,
                                        fit: BoxFit.fill,
                                      ),
                                    ))
                                .toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1.0,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 777),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                height: constraints.maxHeight,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                        Positioned(
                          bottom: constraints.maxHeight * 0.05,
                          child: _buildDotsLoader(),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
