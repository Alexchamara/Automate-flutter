import 'package:automate/screens/product_detail.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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

           //Product 01
            const ProductCard(
                carImage: 'images/cars/audi.jpeg',
                carTitle: 'Audi A4 2020',
                carPrice: 'Rs. 2,500,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '10,000 km',
                carFuelType: 'Petrol',
            ),

            //Product 02
            const ProductCard(
                carImage: 'images/cars/bmw.jpg',
                carTitle: 'BMW 320i 2019',
                carPrice: 'Rs. 2,200,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '15,000 km',
                carFuelType: 'Petrol',
            ),

            //Product 03
           const ProductCard(
                carImage: 'images/cars/corolla.jpg',
                carTitle: 'Toyota Corolla 2019',
                carPrice: 'Rs. 1,795,000',
                carLocation: 'Colombo',
                carCondition: 'Used',
                carMileage: '20,000 km',
                carFuelType: 'Petrol',
            ),
          ],
        ),
      ),
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              children: [
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
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
