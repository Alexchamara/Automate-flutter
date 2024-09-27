import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../layout.dart';
import 'account.dart';

//ProductDetailPage
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  static final String id = 'ProductDetailPage';

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return SafeArea(
          child: Scaffold(
            // App Bar
            appBar: AppBar(
              title: const Text('Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, Layout.id);
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share, color: Colors.white)),
                IconButton(
                  icon: const Icon(Icons.star_border_outlined),
                  color: Colors.white,
                  onPressed: () {
                    // Navigator.pushNamed(context, SearchPage.id);
                  },
                ),
              ],
            ),

            // Body
            body: orientation == Orientation.portrait
                ? const ProductPortrait()
                : const ProductLandscape(),
          ),
        );
      },
    );
  }
}

//ProductPortrait widget
class ProductPortrait extends StatelessWidget {
  const ProductPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ImageSlider(height: 275, fitSize: StackFit.expand),
            SizedBox(height: 20),
            ProductDetails(),
            // Bottom Navigation Bar
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Contact Seller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Chat with Seller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

//ProductLandscape widget
class ProductLandscape extends StatelessWidget {
  const ProductLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSlider(height: 300, fitSize: StackFit.expand),
            SizedBox(height: 20),
            ProductDetails(),
          ],
        ),
      ),
    ));
  }
}

//ImageSlider widget
class ImageSlider extends StatefulWidget {
  final double height;
  final StackFit fitSize;

  const ImageSlider({super.key, required this.height, required this.fitSize});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<Map<String, String>> imageList = [
    {"id": "1", "image_path": "images/cars/adv1.jpg"},
    {"id": "2", "image_path": "images/cars/adv2.jpg"},
    {"id": "3", "image_path": "images/cars/adv3.jpg"},
    {"id": "4", "image_path": "images/cars/adv4.jpg"},
  ];

  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        double height = orientation == Orientation.portrait
            ? widget.height
            : MediaQuery.of(context).size.height * 0.5;

        return Column(
          children: [
            SizedBox(
              height: height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: widget.fitSize,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductDetailPage()),
                      );
                    },
                    child: CarouselSlider.builder(
                      itemCount: imageList.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        // enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        aspectRatio: 1.5,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final image = imageList[index];
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              image["image_path"]!,
                              fit: BoxFit.cover,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

//ProductDetails widget
class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name Section
          Text(
            'Mercedes-Benz A Class',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
          ),

          const SizedBox(height: 10),

          // Product Price
          const Text(
            'Rs. 26,000,000',
            style: TextStyle(
              color: Colors.red,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Product Features
          _sectionTitleWithIcon(context, 'Car Features', Icons.star),
          Text(
            '�� Air Conditioning\n• Airbags\n• Alarm System\n• Alloy Wheels\n• Bluetooth Interface\n• CD/DVD Autochanger\n• Cruise Control\n• Direct Fuel Injection\n• Electric Parking Brake\n• Wind Deflector',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 20),

          // Product Specifications
          _sectionTitleWithIcon(
              context, 'Product Specifications', Icons.rate_review),
          Text(
            '• Condition: Used\n• Fuel: Petrol\n• Engine: 1.4L\n• Transmission: Automatic\n• Year: 2020\n• Mileage: 10,000 km',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 20),

          // Product Description
          _sectionTitleWithIcon(context, 'Description', Icons.description),
          Text(
            'The CEO of an internationally recognised company drives a Mercedes Benz A180 2020 registered car.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Reusable widget for section titles with icons
  Widget _sectionTitleWithIcon(
      BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
          ),
        ],
      ),
    );
  }
}
