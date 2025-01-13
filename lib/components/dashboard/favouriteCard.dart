import 'package:flutter/material.dart';

class favouriteCard extends StatelessWidget {
  const favouriteCard({super.key});

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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // background color
                        foregroundColor: Colors.white, // text color
                      ),
                      onPressed: () {},
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
