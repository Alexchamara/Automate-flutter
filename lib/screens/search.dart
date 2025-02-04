import 'package:automate/controllers/listing_controller.dart';
import 'package:automate/models/listing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:automate/screens/product_detail.dart';
import 'package:flutter/material.dart';

// SearchPage
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static final String id = 'SearchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Listing>> _listings;

  @override
  void initState() {
    super.initState();
    _listings = ListingController.getAllListings();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return SearchPagePortrait(listings: _listings);
        } else {
          return SearchPageLandscape(
            height: MediaQuery.of(context).size.width * 0.35,
            listings: _listings,
          );
        }
      },
    );
  }
}

// SearchPagePortrait
class SearchPagePortrait extends StatefulWidget {
  final Future<List<Listing>> listings;

  const SearchPagePortrait({super.key, required this.listings});

  @override
  State<SearchPagePortrait> createState() => _SearchPagePortraitState();
}

class _SearchPagePortraitState extends State<SearchPagePortrait> {
  List<Listing> _allListings = [];
  List<Listing> _filteredListings = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.listings.then((listings) {
      setState(() {
        _allListings = listings;
        _filteredListings = _allListings;
      });
    });
  }

  void _searchListings(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredListings = _allListings;
      } else {
        _filteredListings = _allListings.where((listing) {
          return listing.advert.model
              .toLowerCase()
              .contains(query.toLowerCase()) ||
              listing.advert.location
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              listing.advert.brand.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                controller: _searchController,
                onChanged: _searchListings,
                decoration: InputDecoration(
                  labelText: 'Search by model, brand, or location',
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.red),
                    onPressed: () {
                      _searchController.clear();
                      _searchListings('');
                    },
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Display products or no results message
            _filteredListings.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'No listings found!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _filteredListings.length,
              itemBuilder: (context, index) {
                final listing = _filteredListings[index];

                return ProductCard(
                  carImage: listing.advert.images.isNotEmpty
                      ? listing.advert.images.first
                      : 'images/default.jpg.webp',
                  carTitle: listing.advert.model,
                  carPrice: 'Rs. ${listing.advert.price}',
                  carLocation: listing.advert.location,
                  carCondition: listing.advert.condition,
                  carMileage: '${listing.advert.mileage} km',
                  carFuelType: listing.advert.fuelType,
                  listing: listing,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// SearchPageLandscape
class SearchPageLandscape extends StatefulWidget {
  final Future<List<Listing>> listings;
  final double height;

  const SearchPageLandscape(
      {super.key, required this.height, required this.listings});

  @override
  State<SearchPageLandscape> createState() => _SearchPageLandscapeState();
}

class _SearchPageLandscapeState extends State<SearchPageLandscape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar
            const ProductSearchBar(),

            // Product Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.15,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FutureBuilder<List<Listing>>(
                  future: widget.listings,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No listings found'));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: snapshot.data!.map((listing) {
                            //Product slider
                            ImageSlider(
                                height: widget.height,
                                fitSize: StackFit.expand);

                            return ProductCard(
                              carImage: listing.advert.images.isNotEmpty
                                  ? listing.advert.images.first
                                  : 'images/default.jpg.webp',
                              carTitle: listing.advert.model,
                              carPrice: 'Rs. ${listing.advert.price}',
                              carLocation: listing.advert.location,
                              carCondition: listing.advert.condition,
                              carMileage: '${listing.advert.mileage} km',
                              carFuelType: listing.advert.fuelType,
                              listing: listing,
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProductDetailPage()),
                  // );
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
  bool _showLocationInputField = false;
  bool _showModelInputField = false;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  List<Listing> _filteredListings = [];

  void _searchListings() async {
    final allListings = await ListingController.getAllListings();
    setState(() {
      _filteredListings = allListings.where((listing) {
        final locationMatch = listing.advert.location
            .toLowerCase()
            .contains(_locationController.text.toLowerCase());
        final modelMatch = listing.advert.brand
            .toLowerCase()
            .contains(_makeController.text.toLowerCase());
        return locationMatch && modelMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                  onPressed: () {
                    setState(() {
                      _showLocationInputField = !_showLocationInputField;
                      _showModelInputField = false;
                    });
                  },
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

            // Model button
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
                  onPressed: () {
                    setState(() {
                      _showModelInputField = !_showModelInputField;
                      _showLocationInputField = false;
                    });
                  },
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
                      Text('Brand', style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
            ),

            // Search button
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: MaterialButton(
                  onPressed: _searchListings,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: const Icon(Icons.search, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
        if (_showLocationInputField)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _locationController.clear();
                  },
                ),
              ),
            ),
          ),
        if (_showModelInputField)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: _makeController,
              decoration: InputDecoration(
                labelText: 'Enter brand name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _makeController.clear();
                  },
                ),
              ),
            ),
          ),
        // Display filtered results
        if (_filteredListings.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: _filteredListings.length,
            itemBuilder: (context, index) {
              final listing = _filteredListings[index];
              return ProductCard(
                carImage: listing.advert.images.isNotEmpty
                    ? listing.advert.images.first
                    : 'images/default.jpg.webp',
                carTitle: listing.advert.brand,
                carPrice: 'Price: Rs.${listing.advert.price}',
                carLocation: listing.advert.location,
                carCondition: listing.advert.condition,
                carMileage: '${listing.advert.mileage} km',
                carFuelType: listing.advert.fuelType,
                listing: listing,
              );
            },
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
  final Listing listing;

  const ProductCard({
    super.key,
    this.carImage,
    this.carFuelType,
    this.carTitle,
    this.carPrice,
    this.carLocation,
    this.carCondition,
    this.carMileage,
    required this.listing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(listing: listing)),
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
                              const Icon(Icons.location_on, color: Colors.grey),
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
