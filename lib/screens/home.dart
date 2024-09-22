import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Search bar
            Row(
              children: [
                // Location
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 40,
                    child: Center(
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.location_on,
                                  color: Color.fromRGBO(11, 25, 111, 1.0)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text('Location'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Category
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey, width: 2.0),
                        right: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                    child: Center(
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.local_offer,
                                  color: Color.fromRGBO(11, 25, 111, 1.0)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text('Category'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Saved Ads
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    child: Center(
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Icon(Icons.bookmark_add_outlined,
                            color: Color.fromRGBO(11, 25, 111, 1.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Main image
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                      child: const Image(
                        image: AssetImage('images/mainImage.png'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    // Main Text
                    const Positioned.fill(
                      child: Center(
                        // child: Text(
                        //   'Find your dream car',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 20.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
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
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Search for your dream car from our wide range of cars',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.center, // Aligns text to the center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Text section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Popular Brands',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Straight to the best cars. We feature great used and new cars that tick every box.',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center, // Aligns text to the center
                    ),
                  ],
                ),
              ),
            ),

            // GridView for car brand
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: CarBrands(),
            ),
          ],
        )
      ),
    );
  }
}

// GridView for car brands
class CarBrands extends StatelessWidget {
  const CarBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Makes GridView fit its content
      physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 100.0, // Space between columns
        mainAxisSpacing: 10.0, // Space between rows
        childAspectRatio: 0.8, // Adjusts the aspect ratio of grid items
      ),
      itemCount: 6, // Total number of grid items
      itemBuilder: (BuildContext context, int index) {
        // List of local image assets and names
        List<String> carImages = [
          'images/nissan.png',
          'images/toyota.png',
          'images/suzuki.png',
          'images/bmw.png',
          'images/honda.png',
          'images/mercedes-benz.png',
        ];

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
              height: 70, // Adjust the image height
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  carImages[index],
                  fit: BoxFit.contain, // Ensure image fits well
                ),
              ),
            ),
            // Display the car name below the image
            const SizedBox(height: 5), // Space between image and text
            Text(
              carNames[index],
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

      },
    );
  }
}
