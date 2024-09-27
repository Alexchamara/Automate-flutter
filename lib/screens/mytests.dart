import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality here
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              width: double.infinity,
              child: Image.network(
                'https://example.com/product-image.jpg', // Replace with product image URL
                fit: BoxFit.cover,
              ),
            ),
            // Product Information
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mitsubishi Outlander 2013',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rs 14,190,000',
                    style: TextStyle(
                        fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text('Negotiable'),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 5),
                      Text('Malabe, Colombo'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  // Seller Information
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://example.com/seller-image.jpg'), // Replace with seller image URL
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Punchi Car Niwasa'),
                          Text(
                            'Member since January 2016',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  // Specifications
                  Text('Specifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     specColumn('Brand', 'Mitsubishi'),
                  //     specColumn('Model', 'Outlander'),
                  //     specColumn('Year', '2013'),
                  //   ],
                  // ),
                  // SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     specColumn('Condition', 'Used'),
                  //     specColumn('Transmission', 'Automatic'),
                  //     specColumn('Body Type', 'SUV / 4x4'),
                  //   ],
                  // ),
                  // SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     specColumn('Fuel Type', 'Hybrid'),
                  //     specColumn('Engine Capacity', '1,990 cc'),
                  //     specColumn('Mileage', '111,133 km'),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  Divider(),
                  // Description
                  Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(
                      'The car is in excellent condition, fully maintained, and is used for personal purposes only.'),
                  SizedBox(height: 10),
                  Divider(),
                  // Similar Products Section
                  Text('Similar Ads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  // similarProductTile('Toyota Aqua 2013', 'Rs 7,690,000', 'https://example.com/aqua-image.jpg'),
                  // similarProductTile('Honda Fit Shuttle 2013', 'Rs 7,985,000', 'https://example.com/honda-image.jpg'),
                  // similarProductTile('BMW X1 2011', 'Rs 10,700,000', 'https://example.com/bmw-image.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for contact or booking
            },
            child: const Text('Contact Seller'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15), backgroundColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  Widget specColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget similarProductTile(String name, String price, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.network(imageUrl, width: 100, height: 70, fit: BoxFit.cover),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(price, style: const TextStyle(fontSize: 16, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}