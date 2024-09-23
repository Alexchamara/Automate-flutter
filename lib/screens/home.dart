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
                    height: 50,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
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
                              color: Theme.of(context).
                              primaryColor
                          ),
                          const SizedBox(width: 2),
                          Text('Location',
                              style: Theme.of(context).
                              textTheme.
                              bodyLarge
                          ),
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                          Icon(Icons.local_offer,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 2),
                          Text('Category',
                              style: Theme.of(context).textTheme.bodyLarge),
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: const Icon(Icons.bookmark_add_outlined,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),

            // Main image
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
                      image: AssetImage('images/mainImage.png'),
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // GridView for car brands
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: CarBrands(),
            ),
          ],
        ),
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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        // childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
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
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 14.0), // No need to specify color
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}
