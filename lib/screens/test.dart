import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            const Text('Popular Brands',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            const Text(
              'Straight to the best cars. We feature great used and new cars that tick every box.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center, // Aligns text to the center
            ),
            const SizedBox(height: 20), // Space before GridView
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 10.0, // Space between columns
                mainAxisSpacing: 10.0, // Space between rows
                children: List.generate(6, (index) {
                  // List of local image assets
                  List<String> carImages = [
                    'images/mainImage.png',
                    'assets/images/car2.jpg',
                    'assets/images/car3.jpg',
                    'assets/images/car4.jpg',
                    'assets/images/car5.jpg',
                    'images/mainImage.png',
                  ];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        carImages[index], // Load the image from assets
                        fit: BoxFit.cover, // Ensure image fits in the container
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
