import 'package:automate/models/listing.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import '../../models/advert.dart';

class AdvertDetailPage extends StatelessWidget {
  final Listing listing;
  final Advert advert;

  const AdvertDetailPage({required this.listing, Key? key, required this.advert}) : super(key: key);

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
                  Navigator.pop(context);
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
                ? ProductPortrait(listing: listing, advert: advert)
                : ProductLandscape(listing: listing, advert: advert),
          ),
        );
      },
    );
  }
}

//ProductPortrait widget
class ProductPortrait extends StatelessWidget {
  final Listing listing;
  final Advert advert;

  const ProductPortrait({required this.listing, super.key, required this.advert});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSlider(height: 275, fitSize: StackFit.expand),
            SizedBox(height: 20),
            ProductDetails(listing: listing, advert: advert),
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
                  'Delete Advert',
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
                color: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Deactive Advert',
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
  final Listing listing;
  final Advert advert;

  const ProductLandscape({required this.listing, super.key, required this.advert});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSlider(height: 300, fitSize: StackFit.expand),
            SizedBox(height: 20),
            ProductDetails(listing: listing, advert: advert),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const AdvertDetailPage()),
                      // );
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
  final Listing listing;
  final Advert advert;

  const ProductDetails({required this.listing, super.key, required this.advert});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                advert.brand,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red, size: 24),
                  const SizedBox(width: 4),
                  Text(
                    advert.location,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 10),

          // Product Price
          Text(
            'Rs.${advert.price.toString()}',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Product Specifications
          _sectionTitleWithIcon(
              context, 'Car Specifications', Icons.rate_review, Colors.red),
          Text(
            '• Condition: ${advert.condition}'
            '\n• Fuel: ${advert.fuelType}'
            '\n• Engine: ${advert.engine}'
            '\n• Transmission: ${advert.gearBox}'
            '\n• Year: ${advert.year}'
            '\n• Mileage: ${advert.mileage} km'
            '\n• Color: ${advert.color}'
            '\n• Body Type: ${advert.bodyType}'
            '\n• Location: ${advert.location}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
          ),

          const SizedBox(height: 20),

          // Contact Details
          _sectionTitleWithIcon(context, 'Seller Details', Icons.contact_phone, Colors.red),
          Text(
            '• Phone: ${advert.phone}'
            '\n• Email: ${advert.email}'
            '\n• Location: ${advert.location}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
          ),

          const SizedBox(height: 20),

          // Product Description
          _sectionTitleWithIcon(context, 'Description', Icons.description, Colors.red),
          Text(
            advert.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 20),

          // Product Features
          _sectionTitleWithIcon(context, 'Advert Details', Icons.details, Colors.red),
          Text(
            '• Advert Status: ${listing.isActive}'
            '\n• Advert ID: ${listing.id}'
            // '\n• Created At: ${formatter.format(listing.createdAt)}'
            // '\n• Updated At: ${formatter.format(listing.updatedAt)}'
            ,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
          ),

          const SizedBox(height: 20),

          //User Details
          _sectionTitleWithIcon(context, 'User Details', Icons.person, Colors.red),
          Text(
            '• User ID: ${listing.userId}'
            // '\n• Token: ${listing.token}'
            '\n• Status: ${listing.status}'
            '\n• Status Updated At: ${formatter.format(listing.statusUpdatedAt)}'
            '\n• Payment Status: ${listing.paymentStatus}'
            '\n• Payment Status Updated At: ${listing.paymentStatusUpdatedAt != null ? formatter.format(listing.paymentStatusUpdatedAt!) : 'N/A'}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  // Reusable widget for section titles with icons
  Widget _sectionTitleWithIcon(
      BuildContext context, String title, IconData icon, Color red) {
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
