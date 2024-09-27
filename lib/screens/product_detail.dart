import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  static final String id = 'ProductDetailPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.share,
                color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
                Icons.star_border_outlined,
                color: Colors.white),
            onPressed: () {
              // Navigator.pushNamed(context, Register.id);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Details of the product'),
      ),
    );
  }
}

// Prefetch image slider
class ImageSlider extends StatefulWidget {
  final double height;
  final StackFit fitSize;

  const ImageSlider({super.key, required this.height, required this.fitSize});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  // Image list and details
  List<Map<String, String>> imageList = [
    {
      "id": "1",
      "image_path": "images/cars/A6.jpg",
      "title": "Toyota Premio G Superior 2016",
      "price": "Rs. 15,450,000"
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
  ];

  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
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
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: 1.5,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),

                  // Image slider
                  itemBuilder: (context, index, realIndex) {
                    final image = imageList[index];

                    // Image with gradient overlay
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent
                              ],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.darken,
                          child: Image.asset(
                            image['image_path'] ?? '',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                        ),

                        // Image title and price
                        Positioned(
                          bottom: 30,
                          child: Container(
                            // color: Colors.black54,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  image['title'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  image['price'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
  }
}
