import 'dart:async';
import 'package:flutter/material.dart';

class CarouselSliderAds extends StatefulWidget {
  const CarouselSliderAds({super.key});

  @override
  State<CarouselSliderAds> createState() => _CarouselSliderAdsState();
}

class _CarouselSliderAdsState extends State<CarouselSliderAds> {
  late final PageController _pageController;
  int pageNo = 0;
  late final Timer carouselTimer;

  final List<Map<String, String>> imageList = [
    {
      "id": "1",
      "image_path": "images/cars/A6.jpg",
      "title": "Toyota Premio G Superior 2016",
      "price": "Rs. 15,450,00"
    },
    {
      "id": "2",
      "image_path": "images/cars/e-trom.jpg",
      "title": "Audi e-trom Q8 2024",
      "price": "Rs. 67,500,000"
    },
    {
      "id": "3",
      "image_path": "images/cars/premio.jpg",
      "title": "Audi A6 Sunroof Fully Loaded 2015",
      "price": "Rs. 24,900,000"
    },
    {
      "id": "4",
      "image_path": "images/cars/premio.jpg",
      "title": "Audi A6 Sunroof Fully Loaded 2015",
      "price": "Rs. 24,900,000"
    },
    {
      "id": "5",
      "image_path": "images/cars/premio.jpg",
      "title": "Audi A6 Sunroof Fully Loaded 2015",
      "price": "Rs. 24,900,000"
    },
  ];

  Timer getTimer() {
    return Timer.periodic(Duration(seconds: 3), (timer) {
      if (pageNo < imageList.length - 1) {
        pageNo++;
      } else {
        pageNo = 0;
      }
      _pageController.animateToPage(
        pageNo,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCirc,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    carouselTimer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                pageNo = index;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (ctx, child) {
                    return child!;
                  },
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                      image: DecorationImage(
                        image: AssetImage(imageList[index]['image_path']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            imageList[index]['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            imageList[index]['price']!,
                            style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: imageList.length,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imageList.length,
              (index) => GestureDetector(
                onTap: () {
                  pageNo = index;
                  _pageController.animateToPage(
                    pageNo,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc,
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.circle,
                    size: 12.0,
                    color: pageNo == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}