import 'package:automate/screens/search.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const HomePortrait();
        } else {
          return const HomeLandscape();
        }
      },
    );
  }
}

// Portrait layout
class HomePortrait extends StatelessWidget {
  const HomePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Top Image
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(
                            0, 5), // changes position of shadow to bottom
                      ),
                    ],
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                    child: const Image(
                      image: AssetImage('images/mainImg.jpg'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250, // Fixed height for better layout
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Find your dream car',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Search for your dream car from our wide range of cars',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Text section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Center(
                child: TextSection(
                    sectionTitle: 'Popular Brands',
                    sectionParagraph:
                        'Straight to the best cars. We feature great used and new cars that tick every box.'),
              ),
            ),

            // GridView for car brands
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: CarBrands(childAspectRatio: 1.2, crossAxisCount: 2),
            ),

            // Ads Carousel Slider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextSection(
                        sectionTitle: 'Featured car deals',
                        sectionParagraph:
                            'Find our best and latest car deals straight from verified sellers.'),
                  ),
                  CarouselSliderAds(
                      stackHeight: 300,
                      stackWidth: double.infinity,
                      carddWidth: double.infinity),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              children: [
                Center(
                  child: Text(
                    'Sell your car with us',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const InfoSection( infoPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Landscape layout
class HomeLandscape extends StatelessWidget {
  const HomeLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(
                            0, 5), // changes position of shadow to bottom
                      ),
                    ],
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                    child: Image(
                      image: const AssetImage('images/mainImg.jpg'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height *
                          0.8, // 30% of screen height // Fixed height for better layout
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Find your dream car',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Search for your dream car from our wide range of cars',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Text section
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Popular Brands',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Straight to the best cars. We feature great used and new cars that tick every box.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // GridView
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: CarBrands(childAspectRatio: 1.5, crossAxisCount: 3),
            ),

            // Carousel Slider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextSection(
                        sectionTitle: 'Featured car deals',
                        sectionParagraph:
                            'Find our best and latest car deals straight from verified sellers.'),
                  ),
                  CarouselSliderAds(
                      stackHeight: 200, stackWidth: 700, carddWidth: 600),
                ],
              ),
            ),
            const Column(
              children: [
                Center(
                  child: Text(
                    'Sell your car with us',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const InfoSection( infoPadding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 10.0)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// GridView for car brands
class CarBrands extends StatelessWidget {
  final childAspectRatio;
  final crossAxisCount;

  const CarBrands({super.key, this.childAspectRatio, this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        // Car images
        List<String> carImages = [
          'images/nissan.png',
          'images/toyota.png',
          'images/suzuki.png',
          'images/bmw.png',
          'images/honda.png',
          'images/mercedes-benz.png',
        ];

        // Car names
        List<String> carNames = [
          'Nissan',
          'Toyota',
          'Suzuki',
          'BMW',
          'Honda',
          'Mercedes',
        ];

        return Column(
          children: [
            // Display the image
            SizedBox(
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  carImages[index],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              carNames[index],
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}

// Ads Carousel Slider
class CarouselSliderAds extends StatefulWidget {
  final double stackHeight;
  final double stackWidth;
  final double carddWidth;

  const CarouselSliderAds(
      {super.key,
      required this.stackHeight,
      required this.stackWidth,
      required this.carddWidth});

  @override
  State<CarouselSliderAds> createState() => _CarouselSliderAdsState();
}

class _CarouselSliderAdsState extends State<CarouselSliderAds> {
  late final PageController _pageController;
  int pageNo = 0;
  late final Timer carouselTimer;

  // List of car images and details
  final List<Map<String, String>> imageList = [
    {
      "id": "1",
      "image_path": "images/cars/A6.jpg",
      "title": "Toyota Premio G Superior",
      "price": "Rs. 15,450,000",
      "location": "Colombo"
    },
    {
      "id": "2",
      "image_path": "images/cars/e-trom.jpg",
      "title": "Audi e-trom Q8 2024",
      "price": "Rs. 67,500,000",
      "location": "Nuwaraeliya"
    },
    {
      "id": "3",
      "image_path": "images/cars/premio.jpg",
      "title": "Audi A6 Sunroof Fully Loaded",
      "price": "Rs. 24,900,000",
      "location": "Panadura"
    },
    {
      "id": "4",
      "image_path": "images/cars/benz.jpg",
      "title": "Mercedes-Benz A Class",
      "price": "Rs. 26,000,000",
      "location": "Colombo"
    },
    {
      "id": "5",
      "image_path": "images/cars/bmw.jpg",
      "title": "BMW M4 2023",
      "price": "Rs. 78,900,000",
      "location": "Jaffna"
    },
  ];

  // Timer for carousel
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo < imageList.length - 1) {
        pageNo++;
      } else {
        pageNo = 0;
      }
      _pageController.animateToPage(
        pageNo,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
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
    return Column(
      children: [
        SizedBox(
          height: widget.stackHeight,
          width: widget.stackWidth,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                pageNo = index;
              });
            },
            itemCount: imageList.length,
            itemBuilder: (context, index) {

              // Animated Builder for Carousel
              return AnimatedBuilder(
                animation: _pageController,
                builder: (ctx, child) {
                  return child!;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [

                      // Card Container with Shadow
                      Container(
                        width: widget.carddWidth,
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              spreadRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(
                            children: [
                              // Car Image
                              Image.asset(
                                imageList[index]['image_path']!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),

                              // Gradient Overlay for Text Visibility
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.2),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),

                              // Floating Price Tag
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    imageList[index]['price']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),

                              // Car Title and Location
                              Positioned(
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      imageList[index]['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.white70,
                                          size: 18.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          imageList[index]['location']!,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Dot Indicators for the Carousel
        const SizedBox(height: 18.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageList.length,
            (index) => GestureDetector(
              onTap: () {
                pageNo = index;
                _pageController.animateToPage(
                  pageNo,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },

              // Dot Indicator
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: pageNo == index ? 16.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: pageNo == index ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// Text section
class TextSection extends StatelessWidget {
  final String sectionTitle;
  final String sectionParagraph;

  const TextSection(
      {super.key, required this.sectionTitle, required this.sectionParagraph});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            sectionParagraph,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

//Info Section
class InfoSection extends StatelessWidget {
  final infoPadding;

  const InfoSection({super.key, this.infoPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: infoPadding,
      child: Column(
        children: [
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Free adverts forever',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Get the best price for your car',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Fast and easy process',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Up to 20 photos for an advert',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Instant messaging with buyers',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Advert reports and analytics',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //add text with icon
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Trade and business accounts',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: 290,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 5)),
              ],
            ),
            child: MaterialButton(
              height: 50,
              onPressed: () {
              },
              child: Text(
                'Start selling',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
