import 'package:automate/components/adminDashboard/advertDetails.dart';
import 'package:flutter/material.dart';

class AdvertCard extends StatelessWidget {
  const AdvertCard({super.key});

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
                Text('title', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5.0),
                Text('Price: price',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5.0),
                Text('Location: location',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5.0),
                Text('Status: status',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('View Advert'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdvertDetails(),
                          ),
                        );
                      },
                      child: const Text('Manage Advert'),
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
