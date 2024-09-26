import 'package:carousel_slider/carousel_slider.dart';
import 'package:automate/screens/product_detail.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static final String id = 'SearchPage';

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const SearchPagePortrait();
        } else {
          return SearchPageLandscape(
            height: MediaQuery.of(context).size.width * 0.35,
          );
        }
      },
    );
  }
}

// SearchPagePortrait
class SearchPagePortrait extends StatelessWidget {
  const SearchPagePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Search Bar
            ProductSearchBar(),

            //Product slider
            ImageSlider(height: 280.0, fitSize: StackFit.loose),

            //Product 01
            ProductCard(
              carImage: 'images/cars/audi.jpeg',
              carTitle: 'Audi A4 2020',
              carPrice: 'Rs. 2,500,000',
              carLocation: 'Colombo',
              carCondition: 'Used',
              carMileage: '10,000 km',
              carFuelType: 'Petrol',
            ),

            //Product 02
            ProductCard(
              carImage: 'images/cars/bmw.jpg',
              carTitle: 'BMW 320i 2019',
              carPrice: 'Rs. 2,200,000',
              carLocation: 'Colombo',
              carCondition: 'Used',
              carMileage: '15,000 km',
              carFuelType: 'Petrol',
            ),

            //Product 03
            ProductCard(
              carImage: 'images/cars/corolla.jpg',
              carTitle: 'Toyota Corolla 2019',
              carPrice: 'Rs. 1,795,000',
              carLocation: 'Colombo',
              carCondition: 'Used',
              carMileage: '20,000 km',
              carFuelType: 'Petrol',
            ),

            //Product 04
            ProductCard(
              carImage: 'images/cars/benz.jpg',
              carTitle: 'Mercedes-Benz A Class',
              carPrice: 'Rs. 26,000,000',
              carLocation: 'Colombo',
              carCondition: 'Used',
              carMileage: '87,000 km',
              carFuelType: 'Petrol',
            ),
          ],
        ),
      ),
    );
  }
}

// SearchPageLandscape
class SearchPageLandscape extends StatelessWidget {
  final double height;

  const SearchPageLandscape({super.key, required this.height});

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          //Product slider
          ImageSlider(height: height, fitSize: StackFit.expand),

          // Search Bar
          const ProductSearchBar(),

          // Product Grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              ProductCard(
                carImage: 'images/cars/audi.jpeg',
                carTitle: 'Audi A4 2020',
                carPrice: 'Rs. 2,500,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '10,000 km',
                carFuelType: 'Petrol',
              ),
              ProductCard(
                carImage: 'images/cars/bmw.jpg',
                carTitle: 'BMW 320i 2019',
                carPrice: 'Rs. 2,200,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '15,000 km',
                carFuelType: 'Petrol',
              ),
              ProductCard(
                carImage: 'images/cars/corolla.jpg',
                carTitle: 'Toyota Corolla 2019',
                carPrice: 'Rs. 1,795,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '20,000 km',
                carFuelType: 'Petrol',
              ),
              ProductCard(
                carImage: 'images/cars/benz.jpg',
                carTitle: 'Mercedes-Benz A Class',
                carPrice: 'Rs. 26,000,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '87,000 km',
                carFuelType: 'Petrol',
              ),
            ],
          ),
        ],
      ),
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

// Search Bar
class ProductSearchBar extends StatefulWidget {
  const ProductSearchBar({super.key});

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Location
        Expanded(
          flex: 2,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3)),
              ],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on,
                      color: Theme.of(context).primaryColor),
                  const SizedBox(width: 2),
                  Text('Location',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ),

        // Category button
        Expanded(
          flex: 2,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3)),
              ],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: 1.3,
                    child: Icon(
                      Icons.local_offer,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text('Model', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ),

        // Saved Ads
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              child: const Icon(Icons.bookmark_add_outlined, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

//Product Card
class ProductCard extends StatelessWidget {
  final carImage;
  final carTitle;
  final carPrice;
  final carLocation;
  final carCondition;
  final carMileage;
  final carFuelType;

  const ProductCard(
      {super.key,
        this.carImage,
        this.carFuelType,
        this.carTitle,
        this.carPrice,
        this.carLocation,
        this.carCondition,
        this.carMileage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 5.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: 300,
            child: Column(
              children: [

                // Car Image
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                      carImage, // Image path
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: Text(carTitle,
                          style:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          )),
                    ),

                    // Price
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 10.0),
                      child: Text(carPrice,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          )),
                    ),

                    // Member and Location
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 10.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(Icons.star,
                                      color: Colors.white, size: 15),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text('Member',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  )),
                              const SizedBox(width: 30),
                              Container(
                                  child: const Icon(Icons.location_on,
                                      color: Colors.grey)),
                              Text(carLocation,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Condition and Mileage
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(carCondition,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              )),
                          const SideBorder(),
                          Text(carMileage,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              )),
                          const SideBorder(),
                          Text('Fuel type: ${carFuelType} ',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Side Border in ProductCard
class SideBorder extends StatelessWidget {
  const SideBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 20.0,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}