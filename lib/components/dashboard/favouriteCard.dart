import 'package:automate/controllers/listing_controller.dart';
import 'package:automate/models/listing.dart';
import 'package:automate/screens/product_detail.dart';
import 'package:flutter/material.dart';

class favouriteCard extends StatelessWidget {
  final Listing listing;

  const favouriteCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/default.jpg.webp',
              fit: BoxFit.cover, width: double.infinity, height: 200),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listing.advert.brand, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5.0),
                Text('Price: Rs.${listing.advert.price}',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5.0),
                Text('Location: ${listing.advert.location}',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5.0),
                Text('Status: ${listing.isActive ? "Active" : "Inactive"}',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(listing: listing),
                          ),
                        );
                      },
                      child: const Text('View Advert'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // background color
                        foregroundColor: Colors.white, // text color
                      ),
                      onPressed: () async {
                        await ListingController.removeFromFavorites(listing.id);
                        // Refresh the list after removing the favorite
                        (context as Element).reassemble();
                      },
                      child: const Text('Remove Favourite'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}